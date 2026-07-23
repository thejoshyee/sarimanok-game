# Sarimanok Survivor - Save System & State Architecture (Weeks 4-5)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** phase-based, no fixed dates — see CLAUDE.md

> **Rewritten 2026-07-22** to match the shipped architecture (drift audit). The
> original "GameState singleton owns everything" design was removed deliberately
> (task 44); this file now documents state ownership as built and specs the
> `SaveManager` autoload still to be built.

---

# Run-State Architecture (As Built — Weeks 1-4)

State is NOT centralized in one singleton. Each autoload owns one job (see
CLAUDE.md §Core Game State Architecture). `GameState` is a thin **reset
orchestrator** — its only public method is `reset_run()`, which fans out per-run
cleanup to the stateful autoloads (`game/autoloads/game_state.gd`).

| State | Owner | Notes |
| --- | --- | --- |
| XP, level, gold (+ kills, score — task 51.2) | `ProgressionManager` | Per-run; gold accrues during the run |
| Passive levels | `PassiveManager` | `get_bonus(id)` / `get_modifier(id)` helpers |
| Elapsed time, run state, win/lose | `GameTimer` | `elapsed_time`, `is_gameplay_active()`, `run_won` / `run_lost` signals |
| Filler stat bonuses | `LevelUpManager` | `filler_damage_bonus`, `filler_speed_bonus` |
| Weapon slots + levels | `WeaponManager` (on Player) | `MAX_WEAPONS = 6`; run starts with Peck (granted in `player.gd _ready`) |
| Effective stats | Computed at call sites | e.g. `stats.max_hp + PassiveManager.get_bonus("thick_plumage")` — no central getters |

**Rules:**

- Do NOT add run-data fields or computed-stat getters to `GameState` — that
  design was removed on purpose (task 44).
- New per-run state goes on the autoload that owns the domain, and MUST be wired
  into that autoload's `reset_run()`.
- Effective values are computed where they're used (multiply `get_modifier()`,
  add `get_bonus()`), matching the existing passive pattern.

---

# SaveManager Autoload (To Build — Week 5)

Persistence lives in a NEW dedicated `SaveManager` autoload (decided
2026-07-22). GameState stays a reset orchestrator; SaveManager owns everything
that outlives a run:

- `load_game()` at startup; `save_game()` on run end, shop purchase, and
  settings change
- The canonical save schema (below), `SAVE_VERSION`, and `migrate_save()` for
  format changes
- Write-backup safety (below)
- Persisted settings (applied at startup; the settings UI arrives in
  prd-polish-feel)

Consumers read persistent values through SaveManager (shop purchase counts,
unlock flags, high scores). Applying those values to gameplay stays at call
sites, same as passives — the exact shop-bonus wiring is specced in
prd-progression-meta when that module is built.

**On run end:** fold the run's gold from `ProgressionManager` into
`SaveManager.gold`, update the high score / best time for the active mode, then
`save_game()`. The exact hand-off is decided when SaveManager is built.

```gdscript
# save_manager.gd — Autoload sketch (build in Week 5)
extends Node

const SAVE_VERSION = 1  # Increment when the schema changes
const SAVE_PATH = "user://save_data.json"

# Persistent data — mirrors the canonical schema below
var gold: int = 0
var shop_damage: int = 0      # times bought
var shop_hp: int = 0          # times bought
var shop_speed: int = 0       # times bought
var high_score_story: int = 0
var high_score_endless: int = 0
var best_time_story: float = 0.0    # seconds
var best_time_endless: float = 0.0  # seconds
var endless_unlocked: bool = false
var shadow_unlocked: bool = false
var golden_unlocked: bool = false
var settings: Dictionary = {}  # defaults per canonical schema

func save_game() -> void:
    pass  # backup first (Save File Safety), then write the canonical schema

func load_game() -> void:
    pass  # read file, check save_version, migrate_save() if older, apply settings

func migrate_save(data: Dictionary, from_version: int) -> Dictionary:
    return data  # add migration steps as the schema evolves
```

---

# Save Data Format (CANONICAL)

Save file location: `user://save_data.json`

**This is the single source of truth for the save schema.** Other PRDs
(prd-progression-meta, prd-characters-variants, prd-characters-endless,
prd-polish-feel) point here and list only the keys they introduce — do not
duplicate this JSON elsewhere.

```json
{
  "save_version": 1,
  "gold": 350,
  "shop_damage": 6,
  "shop_hp": 15,
  "shop_speed": 3,
  "high_score_story": 12450,
  "high_score_endless": 0,
  "best_time_story": 1800.0,
  "best_time_endless": 2843.5,
  "endless_unlocked": false,
  "shadow_unlocked": false,
  "golden_unlocked": false,
  "settings": {
    "music_volume": 0.8,
    "sfx_volume": 1.0,
    "fullscreen": true,
    "window_mode": "fullscreen",
    "screen_shake_enabled": true,
    "reduced_motion": false
  }
}
```

**Times are float seconds** (`1800.0`, not `"30:00"`) — format at display time
via `GameTimer.format_time()`. Storing formatted strings was a drift source in
the original split PRDs.

## Save File Safety

**Always backup before writing** to prevent data loss from crashes or power
failures:

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

**Why this matters**: If save write fails mid-operation (crash, power loss), the
backup ensures the player doesn't lose ALL progress - just the most recent run.

---

> ⚠ **ALREADY PARSED as tasks 48–55.** This Week-4 section is kept for context only — when parsing this module with task-master, EXCLUDE it (or delete the generated duplicates). See the Parse Status table in [../README.md](../README.md).

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
- [ ] SaveManager autoload implemented (schema + versioning + backup)
- [ ] Shop bonuses calculated correctly
- [ ] No console errors

---

**Related Files:**
- [Win Condition & Enemies](prd-progression-victory.md) - Features 7-8
- [Shop System & Score](prd-progression-meta.md) - Features 9-10
- **Next Milestone:** Week 6 (Character Select & Endless Mode) - See [../characters/prd-characters-variants.md](../characters/prd-characters-variants.md)
