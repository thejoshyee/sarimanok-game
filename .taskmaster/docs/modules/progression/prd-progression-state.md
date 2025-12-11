# Sarimanok Survivor - Save System & GameState (Weeks 4-5)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** 14 weeks → Early Access launch ~March 8, 2026

---

# Save Data Format

Save file location: `user://save_data.json`

```json
{
  "gold": 350,
  "shop_damage": 6,
  "shop_hp": 15,
  "shop_speed": 3,
  "high_score_story": 12450,
  "best_time_story": "30:00",
  "endless_unlocked": false,
  "settings": {
    "music_volume": 0.8,
    "sfx_volume": 1.0,
    "fullscreen": false
  }
}
```

## Save File Safety

**Always backup before writing** to prevent data loss from crashes or power failures:

```gdscript
func save_game():
    # Backup existing save before overwriting
    if FileAccess.file_exists("user://save_data.json"):
        var backup_path = OS.get_user_data_dir() + "/save_data.backup.json"
        var source_path = OS.get_user_data_dir() + "/save_data.json"
        DirAccess.copy_absolute(source_path, backup_path)

    # Then write new save...
    var save_data = { ... }
    var file = FileAccess.open("user://save_data.json", FileAccess.WRITE)
    file.store_string(JSON.stringify(save_data))
```

**Why this matters**: If save write fails mid-operation (crash, power loss), the backup ensures the player doesn't lose ALL progress - just the most recent run.

## GameState Singleton (Critical for Week 5)

```gdscript
# GameState.gd - Autoload Singleton
extends Node

# ═══════════════════════════════════════════════
# SAVE FILE VERSIONING
# ═══════════════════════════════════════════════
const SAVE_VERSION = 1  # Increment when save format changes

# ═══════════════════════════════════════════════
# PERSISTENT DATA (Saved to file)
# ═══════════════════════════════════════════════
var gold: int = 0
var shop_damage: int = 0      # Times bought
var shop_hp: int = 0          # Times bought
var shop_speed: int = 0       # Times bought
var high_score_story: int = 0
var best_time_story: float = 0.0

# ═══════════════════════════════════════════════
# RUN DATA (Resets each run)
# ═══════════════════════════════════════════════
var current_hp: int = 100
var max_hp: int = 100
var current_xp: int = 0
var xp_to_next_level: int = 5
var level: int = 1
var score: int = 0
var gold_this_run: int = 0
var time_survived: float = 0.0
var enemies_killed: int = 0

# Weapons: Array of {id, level}
var weapons: Array = []
const MAX_WEAPONS = 6

# Passives: Dictionary of {id: level}
var passives: Dictionary = {}

# ═══════════════════════════════════════════════
# COMPUTED STATS (Base + Shop + Passives)
# ═══════════════════════════════════════════════
func get_damage_multiplier() -> float:
    var shop_bonus = shop_damage * 0.02  # +2% per purchase
    var passive_bonus = passives.get("iron_beak", 0) * 0.10  # +10% per level
    return 1.0 + shop_bonus + passive_bonus

func get_max_hp() -> int:
    var shop_bonus = shop_hp * 5  # +5 per purchase
    var passive_bonus = passives.get("thick_plumage", 0) * 15  # +15 per level
    return 100 + shop_bonus + passive_bonus

func get_move_speed() -> float:
    var base = 200.0
    var shop_bonus = shop_speed * 0.01  # +1% per purchase
    var passive_bonus = passives.get("racing_legs", 0) * 0.10  # +10% per level
    return base * (1.0 + shop_bonus + passive_bonus)

func get_pickup_range() -> float:
    var base = 50.0
    var passive_bonus = passives.get("magnetic_aura", 0) * 0.20  # +20% per level
    return base * (1.0 + passive_bonus)

# ═══════════════════════════════════════════════
# FUNCTIONS
# ═══════════════════════════════════════════════
func reset_run():
    """Call at start of each run."""
    current_xp = 0
    xp_to_next_level = 5
    level = 1
    score = 0
    gold_this_run = 0
    time_survived = 0.0
    enemies_killed = 0
    weapons = [{id = "peck", level = 1}]  # Start with Peck
    passives = {}
    max_hp = get_max_hp()
    current_hp = max_hp

func end_run(won: bool):
    """Call when run ends."""
    gold += gold_this_run
    if won:
        score += 1000  # Victory bonus
    if score > high_score_story:
        high_score_story = score
    if won or time_survived > best_time_story:
        best_time_story = time_survived
    save_game()

func save_game():
    var save_data = {
        "save_version": SAVE_VERSION,
        "gold": gold,
        "shop_damage": shop_damage,
        "shop_hp": shop_hp,
        "shop_speed": shop_speed,
        "high_score_story": high_score_story,
        "best_time_story": best_time_story
    }
    var file = FileAccess.open("user://save_data.json", FileAccess.WRITE)
    file.store_string(JSON.stringify(save_data))

func load_game():
    if FileAccess.file_exists("user://save_data.json"):
        var file = FileAccess.open("user://save_data.json", FileAccess.READ)
        var data = JSON.parse_string(file.get_as_text())

        # Check save version and migrate if needed
        var version = data.get("save_version", 0)
        if version < SAVE_VERSION:
            data = migrate_save(data, version)

        gold = data.get("gold", 0)
        shop_damage = data.get("shop_damage", 0)
        shop_hp = data.get("shop_hp", 0)
        shop_speed = data.get("shop_speed", 0)
        high_score_story = data.get("high_score_story", 0)
        best_time_story = data.get("best_time_story", 0.0)

func migrate_save(data: Dictionary, from_version: int) -> Dictionary:
    """Migrate old save files to current version."""
    # Add migration logic here as save format evolves
    return data
```

---

# Week 4: Win Condition

**End State: "I can WIN the game"**

Builds on Week 3, adds:

- Santelmo enemy (floats, shoots fireballs)
- Manananggal boss spawns at 20:00
- Victory at 30:00 (COCKADOODLEDOO!)
- Results screen (time, kills, score)
- Gold drops from enemies
- Gold persists after run (saved to file)

## Tasks

- [ ] Santelmo enemy (floats, shoots fireballs)
- [ ] Fireball projectile damages player
- [ ] Manananggal boss (spawns at 20:00)
- [ ] Boss has visible HP bar
- [ ] Timer triggers victory at 30:00
- [ ] Victory screen with dawn effect
- [ ] Defeat screen at 0 HP
- [ ] Results screen shows time, kills, score, gold
- [ ] Gold coins drop from enemies
- [ ] Gold persists in save file between runs

**Integration Test:** Can you beat the game (survive to 30:00)?

---

# Definition of Done (Weeks 4-5)

## Win/Lose Conditions

- [ ] Timer counts to 30:00
- [ ] Victory triggers at 30:00
- [ ] COCKADOODLEDOO sound plays
- [ ] Dawn transition effect works (CanvasModulate shift)
- [ ] Defeat triggers at 0 HP
- [ ] Results screen shows stats
- [ ] Can retry from results
- [ ] Gold earned adds to total

## Enemies

- [ ] Santelmo spawns at 10:00
- [ ] Santelmo shoots fireballs every 2 seconds
- [ ] Fireballs damage player on hit
- [ ] Manananggal boss spawns at 20:00
- [ ] Boss has visible HP bar
- [ ] Boss dive attack telegraphs and executes
- [ ] Boss drops 100 gold on death
- [ ] All enemies drop XP + Gold

## Shop System

- [ ] Shop screen displays correctly
- [ ] Can purchase upgrades with gold
- [ ] Gold deducted on purchase
- [ ] Upgrades apply to next run
- [ ] Upgrades persist when game closed
- [ ] BUY button disabled when broke
- [ ] Current bonus displayed

## Score System

- [ ] Score tracks during run
- [ ] Score displays on screen
- [ ] High score saved
- [ ] High score displayed on menu
- [ ] Bonus points for winning
- [ ] Separate tracking for Story Mode

## Technical

- [ ] Save/load works correctly
- [ ] Save file versioning works
- [ ] GameState singleton implemented
- [ ] Shop bonuses calculated correctly
- [ ] No console errors

---

**Related Files:**
- [Win Condition & Enemies](prd-progression-victory.md) - Features 7-8
- [Shop System & Score](prd-progression-meta.md) - Features 9-10
- **Next Milestone:** Week 6 (Character Select & Endless Mode) - See [../characters/prd-characters-variants.md](../characters/prd-characters-variants.md)









