# Sarimanok Survivor - Meta Progression (Weeks 4-5)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** 14 weeks → Early Access launch ~March 8, 2026
- **Price:** $2.99-4.99

By Week 4, you have a complete gameplay loop: Classic Sarimanok, 2 Duwende enemies (Green/Red), 6 weapons, 4 passives, level-up system, and XP/Gold pickups. This milestone adds the **win condition** (survive to 30:00 dawn), remaining enemies (Santelmo, Manananggal boss), **shop system** for permanent upgrades, and **score system**. This completes the core roguelite loop: play → die → spend gold → get stronger → win.

## Dependencies

**Must be completed from Weeks 1-3:**

- Classic Sarimanok (movement, combat, stats)
- Green & Red Duwende enemies
- All 6 weapons functional (Peck, Wing Slap, Feather Shot, Spiral Feathers, Ice Shard, Flame Wing)
- All 4 passives functional (Iron Beak, Thick Plumage, Racing Legs, Magnetic Aura)
- Level-up system with 3 random choices
- XP gems and Gold coins drop from enemies
- Timer counts up from 0:00
- Basic HUD (HP bar, XP bar, timer)
- Game over screen on death

## Deferred to Later Milestones

- **Character select & variants** → Week 6
- **Endless Mode** → Week 6 (unlocks after beating Story Mode)
- **Polish (art, audio, juice)** → Weeks 7-11

---

# Feature 7: Game Timer & Win Condition

**What It Does:**
30-minute timer counts up. Surviving to 30:00 = VICTORY (dawn, rooster crows). HP reaching 0 = DEFEAT.

## Timer Display

```
┌──────────────┐
│    12:47     │
└──────────────┘
```

Position: Top center of screen
Format: MM:SS
Counts UP from 0:00

## Win Condition (Story Mode)

```
Timer reaches 30:00
    ↓
Freeze gameplay
    ↓
Screen brightens (dawn effect)
    ↓
"COCKADOODLEDOO!" text appears
    ↓
Sarimanok crow sound effect
    ↓
"VICTORY! Balance is restored!"
    ↓
Show results screen
```

## Lose Condition

```
Player HP reaches 0
    ↓
Death animation (Sarimanok falls)
    ↓
"You survived 12:47"
    ↓
Show results screen (same as win, different header)
```

## Results Screen

```
┌─────────────────────────────────────┐
│   VICTORY! / DEFEATED               │
│                                     │
│   Time Survived: 30:00 / 12:47      │
│   Enemies Killed: 847               │
│   Score: 15,420                     │
│   Gold Earned: 312                  │
│                                     │
│   [SHOP]   [RETRY]   [MENU]         │
└─────────────────────────────────────┘
```

## Dawn Transition Implementation

**Technical Approach:** The night-to-day transition uses a **CanvasModulate** node to apply a color filter over all game elements. No duplicate tile art is needed—the same tiles are used for both night and day, with the filter creating the time-of-day effect.

**Key Principle:** Tiles are drawn in **normal/natural colors** (as if daytime). The CanvasModulate applies the night tint during gameplay. At victory, the tint fades to reveal the "dawn" version that was there all along.

**Scene Structure:**

```
Main Scene
├── ParallaxBackground (Sky Layer)
│   ├── Sky (ColorRect or Sprite2D - gradient)
│   ├── Moon (Sprite2D - SOURCED, not custom)
│   └── Stars (Sprite2D or particles - SOURCED)
│
├── CanvasModulate (Night Filter - tints everything below)
│
├── Background (Bahay kubo, trees - gets tinted)
├── TileMap (Ground/decorations - gets tinted)
├── Player (gets tinted)
├── Enemies (gets tinted)
└── Camera2D
```

**Color Values:**
| State | CanvasModulate Color | Effect |
| ---------------- | ----------------------- | -------------------------- |
| Night (gameplay) | `Color(0.6, 0.6, 0.8)` | Slight blue/cool tint |
| Dawn (victory) | `Color(1.0, 0.95, 0.9)` | Warm white, natural colors |

**Sky Elements (SOURCED - Not Custom):**

- **Moon:** Source from asset pack or free sprites (32x32 or 48x48)
- **Stars:** Source from asset pack, or use simple white dots/particles
- **Sky gradient:** Can be created in Godot using `GradientTexture2D` (no art file needed)

**Transition Code Example:**

```gdscript
func trigger_dawn_transition():
    var tween = create_tween()

    # 1. Fade out moon and stars (2 seconds)
    tween.tween_property($Moon, "modulate:a", 0.0, 2.0)
    tween.parallel().tween_property($Stars, "modulate:a", 0.0, 2.0)

    # 2. Shift sky gradient from night blue to warm dawn
    tween.parallel().tween_property($Sky, "modulate", Color(1.0, 0.8, 0.6), 2.0)

    # 3. Shift CanvasModulate from night tint to warm dawn
    tween.parallel().tween_property($CanvasModulate, "color", Color(1.0, 0.95, 0.9), 2.0)

    await tween.finished
    # Continue to victory screen, play COCKADOODLEDOO, etc.
```

**Visual Timeline:**
| Time | Sky | Moon/Stars | CanvasModulate |
| ------------------ | --------------------- | ---------- | -------------------- |
| 0:00-29:59 | Dark blue/purple | Visible | Night tint (blue) |
| 30:00 (transition) | Shifts to orange/pink | Fading out | Shifts to warm white |
| 30:02+ | Warm dawn colors | Gone | Natural colors |

---

# Feature 8: Enhanced Enemy Roster

## Santelmo (New Enemy - Week 4)

| Property | Value                              |
| -------- | ---------------------------------- |
| HP       | 15                                 |
| Damage   | 8                                  |
| Speed    | 60                                 |
| Spawns   | 10:00+                             |
| Behavior | Floats, shoots fireballs at player |

**Behavior:**

```
Every frame:
  Float toward player (slower, erratic movement)
  Add slight sine wave to path for "floating" feel

Every 2 seconds:
  Shoot fireball projectile toward player

On contact with player:
  player.take_damage(damage)
```

**Santelmo Fireball Specs:**
| Property | Value |
| -------- | ----------------------------- |
| Speed | 150 pixels/second |
| Damage | 8 |
| Cooldown | 2.0 seconds |
| Size | 16x16 pixels |
| Lifetime | 5 seconds (despawn if no hit) |

**Cultural Note:** Santelmo is "Saint Elmo's Fire" - a ball of floating fire/light that appears in forests, swamps, and open fields. Sometimes believed to be souls of the dead, it leads travelers astray.

## Manananggal Boss (Week 4)

| Property | Value                              |
| -------- | ---------------------------------- |
| HP       | 500                                |
| Damage   | 25                                 |
| Speed    | 90                                 |
| Spawns   | 20:00 (one-time dramatic entrance) |
| Size     | 48x48 sprite (larger than normal)  |

**Behavior:**

```
On spawn:
  Play dramatic entrance (screen shake, screech sound)
  48x48 sprite (larger than normal enemies)

Behavior:
  Fly toward player (medium speed, ignores terrain)
  Every 5 seconds: Dive attack (burst of speed toward player)
  Leaves blood trail visual effect

On death:
  Bonus gold drop (100g)
  Does NOT end game (still must survive to 30:00)
```

**Manananggal Dive Attack Specs:**
| Property | Value |
| ------------- | ------------------------------------------------------ |
| Telegraph | 1.0 second warning (sprite flashes red, screech sound) |
| Dive Speed | 3x normal speed (270 pixels/second) |
| Dive Duration | 0.5 seconds |
| Cooldown | 5.0 seconds between dives |
| Damage | 25 (same as contact damage) |

**Cultural Note:** The Manananggal is a type of Aswang from Filipino folklore. It's a self-segmenting vampire—a woman whose upper torso detaches from her lower body, sprouting bat-like wings to fly through the night hunting prey. More iconic and visually striking than a generic shapeshifter.

## Updated Spawn Timeline (Week 4+)

| Time        | Enemies Spawning               | Spawn Rate          |
| ----------- | ------------------------------ | ------------------- |
| 0:00-8:00   | Green Duwende                  | 1 per 2s → 1 per 1s |
| 8:00-10:00  | Green + Red Duwende            | 1 per 1s            |
| 10:00-20:00 | Green + Red Duwende + Santelmo | 1 per 0.8s → 0.5s   |
| 20:00       | **MANANANGGAL SPAWNS**         | One-time            |
| 20:00-30:00 | All enemies + Manananggal      | 1 per 0.3s (chaos!) |

## Updated Enemy Drops

| Enemy         | XP Drop | Gold Drop |
| ------------- | ------- | --------- |
| Green Duwende | 1       | 1         |
| Red Duwende   | 3       | 2         |
| Santelmo      | 4       | 3         |
| Manananggal   | 50      | 100       |

---

# Feature 9: Shop System

**What It Does:**
Between runs, player can spend gold on permanent stat upgrades that apply to ALL future runs.

**Why It's Important:**
This is the roguelite progression. It's why dying doesn't feel pointless—you always make progress.

## Shop Screen

```
┌─────────────────────────────────────┐
│              SHOP                   │
│                                     │
│   Your Gold: 350                    │
│                                     │
├─────────────────────────────────────┤
│                                     │
│   Damage +2%         100g    [BUY]  │
│   Current: +6%                      │
│                                     │
│   Max HP +5          100g    [BUY]  │
│   Current: +15                      │
│                                     │
│   Move Speed +1%     100g    [BUY]  │
│   Current: +3%                      │
│                                     │
├─────────────────────────────────────┤
│                                     │
│           [BACK TO MENU]            │
│                                     │
└─────────────────────────────────────┘
```

## Permanent Upgrades

| Upgrade    | Cost | Effect          | Repeatable? |
| ---------- | ---- | --------------- | ----------- |
| Damage     | 100g | +2% base damage | ∞ (forever) |
| Max HP     | 100g | +5 max HP       | ∞           |
| Move Speed | 100g | +1% move speed  | ∞           |

**These are SMALL bonuses that stack over many purchases.**

Example: Buy "Damage +2%" 10 times = +20% damage on ALL runs forever.

## Saving Shop Upgrades

Shop purchases persist in save file:

```json
{
  "gold": 350,
  "shop_damage": 6, // +6% damage bought
  "shop_hp": 15, // +15 HP bought
  "shop_speed": 3, // +3% speed bought
  "endless_unlocked": true,
  "high_score": 12450,
  "best_time": "23:47"
}
```

## Technical Requirements

- Shop UI scene
- Load/save shop data to file
- Apply shop bonuses at run start
- Disable BUY button if not enough gold
- Update display after purchase

---

# Feature 10: Score System

**What It Does:**
Tracks score based on enemies killed. Creates leaderboard competition.

## Scoring

| Action                  | Points |
| ----------------------- | ------ |
| Kill Green Duwende      | 10     |
| Kill Red Duwende        | 25     |
| Kill Santelmo           | 40     |
| Kill Manananggal        | 500    |
| Survive to dawn (bonus) | 1,000  |

## Display

Score shows in top-right corner during gameplay:

```
Score: 12,450
```

## High Score

- Saved to file
- Displayed on main menu
- Displayed on results screen
- Separate high scores for Story vs Endless (Endless added in Week 6)

---

# User Interface Screens

## Screen List

| Screen       | Purpose                          |
| ------------ | -------------------------------- |
| Main Menu    | Start game, access shop/settings |
| Shop         | Buy permanent upgrades           |
| Gameplay HUD | HP, XP, timer, score, weapons    |
| Pause Menu   | Resume, settings, quit           |
| Level Up     | Choose upgrade (from Weeks 1-3)  |
| Victory      | Win stats                        |
| Defeat       | Loss stats                       |

## Main Menu Layout

```
┌─────────────────────────────────────────────┐
│                                             │
│            SARIMANOK SURVIVOR               │
│               🐓                            │
│                                             │
│            [STORY MODE]                     │
│            [SHOP]                           │
│            [SETTINGS]                       │
│            [QUIT]                           │
│                                             │
│   Gold: 350    High Score: 12,450           │
│                                             │
│                              v0.1.0         │
└─────────────────────────────────────────────┘
```

**Loading Screen Text:**

> "The Sarimanok guards the land through the night. Survive until dawn."

Displayed briefly when starting a run (during scene transition).

## Gameplay HUD Layout

```
┌─────────────────────────────────────────────┐
│  ❤️ ████████░░  [12:47]     Score: 12,450  │
│  ⭐ ████░░░░░░                              │
│                                             │
│                                             │
│               (gameplay)                     │
│                                             │
│                                             │
│                                             │
│  🗡️ Peck Lv.3  💨 Wing Slap Lv.2           │
└─────────────────────────────────────────────┘
```

- Top left: HP bar, XP bar
- Top center: Timer
- Top right: Score
- Bottom: Equipped weapons with levels

## Pause Menu

```
┌─────────────────────────────────────────────┐
│                                             │
│               PAUSED                        │
│                                             │
│             [RESUME]                        │
│             [SETTINGS]                      │
│             [QUIT TO MENU]                  │
│                                             │
└─────────────────────────────────────────────┘
```

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

# Week 5: Meta Progression

**End State: "Dying makes me stronger for next run"**

Builds on Week 4, adds:

- Main menu (Story Mode, Shop, Quit)
- Shop screen with 3 upgrades (Damage, HP, Speed)
- Shop upgrades apply at run start
- Shop upgrades persist in save file
- Gold deducts on purchase

## Tasks

- [ ] Main menu screen (Story Mode, Shop, Quit)
- [ ] Add loading screen tagline ("The Sarimanok guards the land through the night...")
- [ ] Shop screen UI (use purchased UI asset pack)
- [ ] Buy Damage upgrade (+2% per purchase)
- [ ] Buy HP upgrade (+5 per purchase)
- [ ] Buy Speed upgrade (+1% per purchase)
- [ ] Upgrades save to file
- [ ] Upgrades apply at run start
- [ ] Gold deducts correctly on purchase
- [ ] BUY button disabled when insufficient gold

**Integration Test:** Die, buy upgrade, start new run - are you stronger?

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

**Next Milestone:** Week 6 (Character Select & Endless Mode) - See `prd-characters.md`
