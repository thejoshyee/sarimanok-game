# Drift Audit — Module PRDs vs tasks.json vs Code

Generated 2026-07-22. Sources: the 15 PRDs in `.taskmaster/docs/modules/`, `.taskmaster/docs/full-release-roadmap.md`, `.taskmaster/tasks/tasks.json` (55 tasks, tag `master`), and the `game/` source tree. `.taskmaster/docs/prd.md` treated as historical and ignored.

---

## 1. STATUS TABLE

| Module PRD | tasks.json | Code | Verdict |
|---|---|---|---|
| core/prd-core-foundation.md | Tasks 1–10 all done | Confirms: 640×360 viewport + canvas_items (`game/project.godot`), analog input map with controller bindings, player controller with 0.5s i-frames (`game/scripts/player/player.gd:15-16`), pooling (`game/autoloads/pool_manager.gd`), spatial grid (`game/autoloads/grid_manager.gd`), perf test scenes (`game/scenes/tests/performance_test.tscn`) | **done** |
| core/prd-core-enemies.md | Tasks 11–16 done (subtask 16.3 still `pending`) | Confirms stats/scaling/ring-spawn/drops (`game/scripts/enemies/enemy_duwende.gd`, `game/autoloads/spawn_manager.gd`, `game/scripts/core/enemy_spawner.gd`, `game/scenes/enemies/duwende/red_duwende.tscn`) | **done** — ⚠ flags A, B |
| core/prd-core-weapons.md | Tasks 17–26 done; task 27 (art checkpoint) deferred | Confirms 6 data-driven weapons (`game/weapons/data/*.tres`, `game/weapons/scripts/weapon_database.gd`), 6-slot limit, debuff system (`game/scripts/enemies/debuff_handler.gd`) | **done** (art checkpoint open) — ⚠ flag C |
| core/prd-core-progression.md | Tasks 28–37 done (+ fix tasks 38–40, 43–46 done) | Confirms linear XP curve (`game/resources/progression.gd:15-16`), 4 passives with PRD values (`game/resources/passives/*.tres`), dynamic level-up choices + fillers (`game/autoloads/level_up_manager.gd`), pickup magnet (`game/scripts/pickups/xp_gem.gd:21-28`) | **done** — ⚠ flag D |
| core/prd-core-arena.md | **No tasks reference this PRD** (not indexed in `modules/README.md` either) | Partially implemented: 3072×2048 constants (`game/scripts/core/main.gd:6-7`, `game/scripts/core/enemy_spawner.gd:16-17`), camera limits 3072/2048 (`game/main.tscn:92-95`), 4 boundary walls (`game/main.tscn:120-142`), `game/assets/tilesets/placeholder_farm.png`, painted Ground TileMapLayer, night CanvasModulate (`game/main.tscn:146-147`). Only one TileMapLayer exists (`Ground`, `game/main.tscn:85`) — the PRD's Decoration layer, zone layout, and POIs (bahay kubo, rice paddies, plots, well) are unverified from scene data | **in-progress** — ⚠ flag E |
| progression/prd-progression-victory.md | Tasks 48–50 done, 51 in-progress, 52–55 pending | Timer/win/lose/freeze confirmed (`game/autoloads/game_timer.gd`), dawn tween confirmed (`game/scripts/core/dawn_controller.gd`), results screen is a bare stub (`game/scenes/ui/results_screen.tscn`, consistent with 51.1). No Santelmo/Manananggal code exists (consistent with 52–54 pending) | **in-progress** — ⚠ flags F, G |
| progression/prd-progression-meta.md | No tasks (results-screen SHOP button lives under pending subtask 51.6) | No shop, no score tracking (`grep score` over `game/**/*.gd` → 0 hits), no main menu scene, no high-score storage | **untouched** |
| progression/prd-progression-state.md | No tasks | No save/load code outside test scripts (`FileAccess` only in `game/scripts/tests/`). An autoload named GameState exists but is a 5-line reset orchestrator (`game/autoloads/game_state.gd`), not the PRD's persistent-data singleton | **untouched** — ⚠ flag H |
| characters/prd-characters-variants.md | No tasks | Only Classic exists: one stats resource with zero overridden values (`game/resources/classic_sarimanok_stats.tres`); no Shadow/Golden resources, no character-select scene, no unlock logic | **untouched** |
| characters/prd-characters-endless.md | No tasks | No mode flag anywhere (`grep endless` → 0 hits); victory hardcoded at 30:00 (`game/autoloads/game_timer.gd:21,27-28`) | **untouched** |
| polish/prd-polish-feel.md | No tasks (ad-hoc task 42, AOE visibility, is adjacent scope and deferred) | No settings menu/persistence, no screen shake, no hitstop, no input-device detection (`grep screen_shake|reduced_motion` → 0 hits). Fragments exist: SFX volume slider in pause menu (`game/scripts/ui/pause_menu.gd:12,50`), Master/SFX/Music buses (`game/default_bus_layout.tres`) | **untouched** |
| polish/prd-polish-content.md | No tasks (deferred art checkpoints 27 and 55 feed into it) | No real sprites (`game/assets/sprites/` contains only `.gitkeep`), no music, 5 placeholder SFX files only (`game/assets/audio/sfx/`) | **untouched** |
| polish/prd-polish-release.md | No tasks (ad-hoc task 41, balance pass, is adjacent scope and in-progress with 4 deferred subtasks) | No demo flag, GodotSteam, achievements, or analytics (`grep is_demo|steam` → 0 hits) | **untouched** — ⚠ flag I |
| launch/prd-launch-prep.md | No tasks | Nothing in repo; all calendar deadlines in the PRD (Jan 5 / Feb 9 / Feb 23 / ~Mar 8 2026, `prd-launch-prep.md:34-41`) have passed | **untouched** |
| launch/prd-launch-execute.md | No tasks | Nothing in repo | **untouched** |

### Flags (rows where tasks.json and code disagree)

- **A — Subtask 16.3 pending but implemented and parent closed.** Task 16 is `done` while 16.3 "Add Particle Effects and Pool Return" is `pending`; the code has both (death particles + pool return, `game/scripts/enemies/enemy_duwende.gd:115-141`).
- **B — Enemy body type contradicts the PRD both docs-side and code-side.** `prd-core-enemies.md:122` requires "Area2D (NOT CharacterBody2D)" and Task 11 is titled "…with Area2D" and marked done — but `game/scripts/enemies/enemy_duwende.gd:1` extends CharacterBody2D and uses `move_and_slide()` (`:193`). (The PRD is internally inconsistent: its own behavior pseudocode at `prd-core-enemies.md:66` calls `move_and_slide()`, a physics-body API.)
- **C — Peck implemented as projectile, not melee cone.** `prd-core-weapons.md:21,30-35` and Task 20 ("melee cone weapon… Area2D damage detection", done) specify a cone jab; `game/weapons/data/peck.tres` is "Fires sharp beak projectiles" with `projectile_count`/`spread_angle`, fired from the `projectile_beak` pool. Damage/cooldown numbers do match the PRD table.
- **D — PRD checklist items with no task and no code.** Week 2–3 placeholder SFX list (`prd-core-progression.md:247-249,286-290`) covers 8+ sounds; `game/assets/audio/sfx/` has 5 (enemy_hit, enemy_death, xp_pickup, gold_pickup, level_up) — the four weapon sounds are absent. Week 1 localization prep (`tr()` + `localization/translations.csv`, `prd-core-progression.md:213-214`): no `tr()` calls and no translations file exist (only a TODO at `game/weapons/scripts/weapon_data.gd:7`).
- **E — Arena work is untracked in tasks.json.** Code implements much of `prd-core-arena.md` (dimensions, camera, walls, tileset, night tint) but no task covers it, and `modules/README.md:3,9` still says "14 files" / "core (4 files)", omitting prd-core-arena.md. Task-status cannot be judged from tasks.json for this module at all.
- **F — Task 50 marked done but half its scope is absent.** Its description includes "parallax sky layer with moon and stars plus a global CanvasModulate"; CanvasModulate + tween exist (`game/scripts/core/dawn_controller.gd:16-24`) but there is no ParallaxBackground/Moon/Stars node anywhere (`grep -i parallax|moon|star` over `game/**/*.tscn,*.gd` → 0 matches). The PRD scene structure (`prd-progression-victory.md:97-113`) is not reflected in `game/main.tscn`.
- **G — HUD timer counts down; PRD and Task 49 say count up.** `prd-progression-victory.md:32` ("30-minute timer counts up", §Timer Display "Counts UP from 0:00") and Task 49 ("reading GameTimer.elapsed_time", done) — but `game/scripts/ui/hud.gd:40-41` renders `1800.0 - elapsed_time` clamped at 0, i.e. a countdown.
- **H — GameState name is occupied by a different design.** `prd-progression-state.md:53-180` specs GameState as the owner of persistent + run data with computed-stat getters. The registered autoload (`game/project.godot:35`, `game/autoloads/game_state.gd:1-9`) only fans out `reset_run()` to five other autoloads; run state actually lives in ProgressionManager/PassiveManager/GameTimer/LevelUpManager (Task 44, done, deliberately removed phantom GameState APIs from docs).
- **I — Renderer contradicts the untouched Steam PRD.** `prd-polish-release.md:88` requires Compatibility rendering ("Forward+ breaks overlay"); `game/project.godot:19` is configured `"Forward Plus"`.

---

## 2. CROSS-DOC CONTRADICTIONS

1. **Arena size — one PRD vs three.** `prd-core-arena.md:19` specs 3072×2048 (96×64 tiles) and admits it's "2.5x larger than original spec" (`:9`), but the older numbers were never propagated: `prd-core-foundation.md:50` still says 1920×1088 (60×34), `prd-core-enemies.md:88` says clamp spawns to "map bounds (0-1920, 0-1088)", and `prd-core-progression.md:201-202` tasks "Paint basic 60×34 arena" / "Camera2D with limits (0,0 to 1920,1088)". Code follows the arena PRD (`game/scripts/core/main.gd:6-7`).

2. **Enemy spawn placement — ring vs arena edges.** `prd-core-enemies.md:81-89` specs spawning in a ring ~465px around the player via polar coordinates, clamped inside map bounds. `prd-core-arena.md:195-206` specs spawning along the four arena edges, 32–64px *outside* the boundary. These are mutually exclusive systems. Code implements the ring (`game/scripts/core/enemy_spawner.gd:60-68`).

3. **Save-file schema — key names differ between the two PRDs that define it.** `prd-progression-meta.md:62-72` uses `high_score` / `best_time` (and shows `endless_unlocked: true`); `prd-progression-state.md:16-31` uses `high_score_story` / `best_time_story` plus a `save_version` written by its `save_game()` (`:146-155`) that meta's format lacks. Additionally, state's GDScript stores `best_time_story` as `float` (`:73`) while its own JSON example and `prd-characters-variants.md:138` / `prd-characters-endless.md:112-113` show it as the string `"30:00"`.

4. **Settings schema — state vs polish-feel.** `prd-progression-state.md:25-29` saves 3 settings keys (music_volume, sfx_volume, fullscreen); `prd-polish-feel.md:52-62` saves 6 (adds window_mode, screen_shake_enabled, reduced_motion). Neither references the other, and the GameState GDScript spec in `prd-progression-state.md:55-180` declares no `settings` variable at all — yet `prd-polish-feel.md:99` calls `GameState.settings.screen_shake_enabled`.

5. **EA price — roadmap pins it, PRDs give a range.** `full-release-roadmap.md:215-222` ("Your Pricing Plan") sets EA launch at $2.99 with the increase to $4.99 reserved for 1.0. The module PRDs state "Price: $2.99-4.99" for the EA launch itself (`prd-core-foundation.md:10`, `prd-progression-victory.md:9`, `prd-characters-variants.md:9`, `prd-launch-prep.md:9`, `prd-launch-execute.md:9`) and the demo end screen shows "Full game: $2.99-4.99 Early Access" (`prd-polish-release.md:49`).

6. **Module index vs directory contents.** `modules/README.md:3` says the PRD was "split into 14 smaller, focused files" and lists core as 4 files (`:9,20-23`); the directory contains 15 module PRDs — `core/prd-core-arena.md` is absent from the index, its line-count table (`:129-148`), and its parse instructions (`:112-127`). Consequence visible in tasks.json: it is the one module with implementation but zero tasks (Status table, flag E).

---

## 3. INHERITED ASSUMPTIONS (untouched modules)

### progression/prd-progression-meta.md
- **Gold drops from enemies and accumulates** (`prd-progression-meta.md:15`): confirmed — `game/scripts/enemies/enemy_duwende.gd:134-138`, `game/resources/progression.gd:26-27`.
- **Gold persists between runs** (shop spends it across sessions): partially — `ProgressionManager.gold` survives run resets in-session (`game/resources/progression.gd:31-34` doesn't clear it) but there is no save file, so it is lost on quit.
- **Kill/score counters exist to feed the score table** (`prd-progression-meta.md:89-97`): not built — no score or kill tracking in any script; planned under pending subtask 51.2.
- **Main Menu / Victory / Defeat screens exist to host shop entry and high score** (`prd-progression-meta.md:117-128`): not built — no main-menu scene; results screen is an empty CanvasLayer stub (`game/scenes/ui/results_screen.tscn`).
- **"Apply shop bonuses at run start" has a stat pipeline to hook into** (`prd-progression-meta.md:78`): no such hook — effective stats are computed at call sites from PlayerStats + PassiveManager only (`game/scripts/player/player.gd:38,152-153`, `game/weapons/scripts/weapon.gd:67-70`).

### progression/prd-progression-state.md
- **GameState singleton will own run + persistent data** (`prd-progression-state.md:53-180`): contradicted by code — the name is taken by a thin reset orchestrator (`game/autoloads/game_state.gd:1-9`); run state is distributed across ProgressionManager, PassiveManager, GameTimer, LevelUpManager (see flag H).
- **Run starts with Peck at level 1** (`prd-progression-state.md:130`): confirmed — `game/scripts/player/player.gd:104-108`, though owned by WeaponManager, not a weapons array on GameState.
- **XP starts at level 1 needing 5 XP** (`prd-progression-state.md:80-81`): confirmed — `game/resources/progression.gd:8-16`.
- **A settings dict exists to serialize** (`prd-progression-state.md:25-29`): not built (polish-feel untouched).

### characters/prd-characters-variants.md
- **Character stats are loadable per-selection** (`prd-characters-variants.md:117`): seam confirmed — player takes an `@export var stats: PlayerStats` resource (`game/scripts/player/player.gd:3`, `game/resources/player_stats.gd`); only the Classic resource exists and it overrides nothing (all values are script defaults).
- **A damage% stat affects weapons** (Shadow's 125%, `prd-characters-variants.md:37`): unwired — `PlayerStats.damage_multiplier` exists (`game/resources/player_stats.gd:6`) and `WeaponManager.get_damage_multiplier()` reads it (`game/weapons/scripts/weapon_manager.gd:66-67`), but nothing calls it; weapon damage applies only iron_beak and filler bonuses (`game/weapons/scripts/weapon.gd:67-70`).
- **Survival time is queryable for the 15:00 unlock** (`prd-characters-variants.md:147-149`): confirmed as `GameTimer.elapsed_time` (`game/autoloads/game_timer.gd:15`) — not `GameState.time_survived` as the PRD writes it.
- **Save file stores unlock flags** (`prd-characters-variants.md:124-139`): not built — no save system.

### characters/prd-characters-endless.md
- **The 30:00 victory check can be disabled per mode** (`prd-characters-endless.md:74`): not built — victory fires unconditionally at `VICTORY_TIME` inside `GameTimer._process` (`game/autoloads/game_timer.gd:23-28`); no mode flag exists.
- **Spawn/stat scaling extrapolates past 30:00** (`prd-characters-endless.md:36-38`): confirmed — both are open-ended functions of elapsed minutes (`game/autoloads/spawn_manager.gd:12-29`) with no cap in `game/scripts/core/enemy_spawner.gd`.
- **Timer display works past 30:00 counting up** (`prd-characters-endless.md:32`): contradicted — HUD renders `1800 − elapsed` floored at 0 (`game/scripts/ui/hud.gd:40-41`), which would sit at 00:00 forever in Endless.
- **`endless_unlocked` persists in save** (`prd-characters-endless.md:99-115`): not built — no save system.

### polish/prd-polish-feel.md
- **Full MVP exists (win condition, 3 characters, shop, Endless, save)** (`prd-polish-feel.md:12-25`): not met — Santelmo/boss/results (tasks 51–55 open), shop, save, variants, Endless all absent.
- **`GameState.settings.screen_shake_enabled` is readable** (`prd-polish-feel.md:99`): absent — GameState has no settings (flag H).
- **Audio buses exist for volume sliders** (§Settings): confirmed — Master/SFX/Music in `game/default_bus_layout.tres`; a non-persisted SFX slider already exists in `game/scripts/ui/pause_menu.gd:12,50`.
- **Damage numbers, enemy flash, invincibility flash "already implemented in Week 3"** (`prd-polish-feel.md:147`): confirmed — `game/scripts/enemies/enemy_duwende.gd:71-93`, `game/scripts/player/player.gd:70-76`.
- **Controller input mapped since Week 1** (`prd-polish-feel.md:153`): confirmed — joypad events on all move/pause actions in `game/project.godot`.
- **Settings reachable from main menu and pause menu** (`prd-polish-feel.md:66`): pause menu exists (`game/scenes/ui/pause_menu.tscn`); main menu does not.
- **An `EventBus` autoload for `input_device_changed`** (`prd-polish-feel.md:174`): absent — not in `game/project.godot` autoloads.

### polish/prd-polish-content.md
- **Sprites are swappable children (ColorRect → Sprite2D, no logic changes)** (`prd-polish-content.md:49-56`): confirmed — player visual is a named child (`game/scripts/player/player.gd:6`); enemy visual is typed `CanvasItem` explicitly for the swap (`game/scripts/enemies/enemy_duwende.gd:32-34`).
- **All Week 2–3 placeholder SFX exist to be replaced** (`prd-polish-content.md:118-129`): partially — 5 of the 8 listed exist; Peck/Wing Slap/Feather Shot/Spiral Feathers sounds are missing (`game/assets/audio/sfx/`).
- **A central AudioManager for pitch randomization** (`prd-polish-content.md:145-156`): absent — current SFX are per-node AudioStreamPlayer2Ds (`game/scripts/enemies/enemy_duwende.gd:86-89,111-113`).
- **Boss exists for the 48×48 art slot and `_on_boss_spawn()` music trigger** (`prd-polish-content.md:46,179,278`): absent — Manananggal not implemented (task 53 pending).
- **Tileset slot ready for asset-pack art** (`prd-polish-content.md:36`): confirmed — `game/assets/tilesets/placeholder_farm.png` + painted Ground layer in `game/main.tscn`.

### polish/prd-polish-release.md
- **Compatibility renderer for Steam overlay** (`prd-polish-release.md:88`): contradicted — `game/project.godot:19` uses Forward Plus (flag I).
- **`GameState.is_demo` and `time_survived` for the demo timer** (`prd-polish-release.md:56-62`): absent — GameState has neither; elapsed time lives on GameTimer (`game/autoloads/game_timer.gd:15`).
- **Run stats for achievements/analytics (kills, cause_of_death, weapons_chosen, shop purchases)** (`prd-polish-release.md:73-81,105-120`): mostly absent — no kill/score tracking (51.2 pending), no damage-source tracking, no shop; weapon list/levels are available via WeaponManager (`game/weapons/scripts/weapon_manager.gd`).
- **"Endless Night: survive 45:00 in Endless" achievement** (`prd-polish-release.md:81`): Endless Mode absent.
- **200+ enemies @ 60 FPS validated** (`prd-polish-release.md:268`): perf-test scenes exist and Week-3-scale validation is done (tasks 10, 37); the 200+ figure at current content is unverified.

### launch/prd-launch-prep.md
- **Weeks 1–11 complete: code complete, art/audio integrated, demo submitted Feb 9, achievements, analytics, trailer** (`prd-launch-prep.md:15-27`): not met — polish and half of progression are untouched (see Status table); no demo build, no Steam integration, no marketing assets in repo. All fixed dates (`:34-41`) have passed; whether external assets (capsule commission, screenshots) exist outside the repo is unverified.

### launch/prd-launch-execute.md
- **Launch-prep complete (store page live, demo in Next Fest)** (`prd-launch-execute.md:13-19`): not met — prd-launch-prep untouched.
- **Achievements + analytics feeding launch metrics** (`prd-launch-execute.md:126-140`): absent — neither exists in code.
- **Update 1 content pulled from a shipped EA baseline (Black Duwende, enhanced Endless scaling)** (`prd-launch-execute.md:163-175`, matching `full-release-roadmap.md:122-131`): baseline not shipped; Black Duwende and Endless Mode have no code.
