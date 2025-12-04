# Sarimanok Survivor - Development PRD

**Purpose:** Focused PRD for task-master parsing. See `prd.md` for full reference.

**Engine:** Godot 4.x (GDScript)
**Art:** 32x32 sprites (48x48 boss), 16x16 icons
**Target:** 30-minute survival runs, 60 FPS with 200+ enemies

---

## Core Systems Overview

| System | Priority | Dependencies |
|--------|----------|--------------|
| Project Setup | High | None |
| Player Characters | High | Project Setup |
| Enemy System | High | Player |
| Weapon System | High | Player, Enemies |
| Passive System | Medium | Player, Weapons |
| Level-Up System | High | Weapons, Passives |
| Pickup System | Medium | Enemies, Passives |
| Shop System | High | Pickups |
| Timer/Win/Lose | High | Player, Enemies, Shop |
| Endless Mode | Medium | Timer/Win |

---

## System 1: Project Setup

**Functional Requirements:**
- FR-1.1: Configure viewport 640x360, stretch mode canvas_items, aspect keep
- FR-1.2: Set up Input Map: move_up, move_down, move_left, move_right, pause, ui_accept, ui_cancel
- FR-1.3: Create TileMap with 2 layers (ground, decorations)
- FR-1.4: Configure Camera2D with limits (0,0 to 1920,1088)
- FR-1.5: Add invisible boundary collision using StaticBody2D
- FR-1.6: Initialize object pools: 300 enemies, 200 projectiles, 500 pickups, 100 particles
- FR-1.7: Set up Audio buses: Master, Music, SFX
- FR-1.8: Create localization CSV with tr() function usage

**Test Criteria:**
- [ ] Project runs at target resolution
- [ ] All input actions respond correctly
- [ ] Camera respects bounds
- [ ] Object pools pre-allocate correctly

---

## System 2: Player Characters (3 Variants)

**Character Stats:**

| Variant | HP | Speed | Damage | Unlock |
|---------|-----|-------|--------|--------|
| Classic (Rainbow) | 100 | 100% | 100% | Default |
| Shadow (Purple) | 80 | 100% | 125% | Survive 15:00 Story |
| Golden (Gold/Red) | 130 | 85% | 100% | Beat Story Mode |

**Functional Requirements:**
- FR-2.1: CharacterBody2D with 8-directional movement using Input.get_action_strength()
- FR-2.2: 2-frame animation, sprite flips based on velocity.x
- FR-2.3: Base move speed 200 pixels/second, modified by character
- FR-2.4: Collision shape for enemy damage detection
- FR-2.5: Invincibility frames (0.5s) after taking damage with visual flash
- FR-2.6: Death triggers at HP = 0
- FR-2.7: Character select screen with lock/unlock display
- FR-2.8: Unlock conditions checked against GameState

**Test Criteria:**
- [ ] Movement smooth in all 8 directions
- [ ] Damage and invincibility work correctly
- [ ] Character unlocks trigger at correct conditions

---

## System 3: Enemy System (4 Types)

**Enemy Stats:**

| Enemy | Size | HP | Damage | Speed | Spawns At |
|-------|------|-----|--------|-------|-----------|
| Green Duwende | 32x32 | 10 | 5 | 80 | 0:00+ |
| Red Duwende | 32x32 | 25 | 10 | 100 | 8:00+ |
| Santelmo | 32x32 | 15 | 8 | 60 | 10:00+ |
| Manananggal | 48x48 | 500 | 25 | 90 | 20:00 (Boss) |

**Functional Requirements:**
- FR-3.1: Use Area2D for enemies (NOT CharacterBody2D) for performance
- FR-3.2: Enemies move toward player position each frame
- FR-3.3: Enemies pass through each other but collide with player
- FR-3.4: Spawn at random screen edge positions
- FR-3.5: Spawn rate scales: 2.0s base, increases 5% per minute
- FR-3.6: Enemy HP/damage scales over time (+5% HP per 5min, +3% damage per 5min)
- FR-3.7: Death triggers particle effect, XP gem drop, Gold coin drop
- FR-3.8: Santelmo shoots fireballs (150 speed, 2s cooldown, 8 damage)
- FR-3.9: Manananggal dive attack (1s telegraph, 3x speed for 0.5s, 5s cooldown)
- FR-3.10: Use object pooling for all enemies and projectiles

**Test Criteria:**
- [ ] 100+ enemies at 60 FPS
- [ ] 200+ enemies at 60 FPS (Week 6+)
- [ ] Spawn timeline matches spec
- [ ] Boss spawns at exactly 20:00

---

## System 4: Weapon System (6 Weapons)

**Weapon Stats:**

| Weapon | Type | Cooldown | Base Damage | Max Level |
|--------|------|----------|-------------|-----------|
| Peck | Melee | 0.5s | 10 | 5 |
| Wing Slap | AOE | 1.5s | 8 | 5 |
| Feather Shot | Projectile | 1.0s | 12 | 5 |
| Spiral Feathers | Orbital | Passive | 6 | 5 |
| Ice Shard | Projectile (clone) | 1.2s | 10 | 5 |
| Flame Wing | AOE (clone) | 1.5s | 10 | 5 |

**Functional Requirements:**
- FR-4.1: Weapons auto-fire on cooldown (no attack button)
- FR-4.2: WeaponData Resource class for data-driven definitions
- FR-4.3: Weapon manager tracks equipped weapons (max 6)
- FR-4.4: Peck: damages enemies in cone in front of player
- FR-4.5: Wing Slap: damages all enemies in radius around player
- FR-4.6: Feather Shot: projectile toward nearest enemy, pierces based on level
- FR-4.7: Spiral Feathers: 4 feathers orbit player, damage on contact
- FR-4.8: Ice Shard: slower Feather Shot + 0.5s slow debuff (50% speed)
- FR-4.9: Flame Wing: smaller Wing Slap radius, +20% damage
- FR-4.10: Debuff system for slow effect
- FR-4.11: Show damage numbers on enemy hit

**Test Criteria:**
- [ ] All weapons fire automatically
- [ ] Upgrades increase damage/effects correctly
- [ ] Clone weapons apply correct modifiers

---

## System 5: Passive System (4 Passives)

**Passive Stats:**

| Passive | Per Level | Max Level | Total |
|---------|-----------|-----------|-------|
| Iron Beak | +10% Damage | 5 | +50% |
| Thick Plumage | +15 Max HP | 5 | +75 HP |
| Racing Legs | +10% Speed | 5 | +50% |
| Magnetic Aura | +20% Pickup Range | 5 | +100% |

**Functional Requirements:**
- FR-5.1: Passive manager tracks levels per passive
- FR-5.2: Apply modifiers additively to player stats
- FR-5.3: Passives stack with weapon upgrades and shop bonuses
- FR-5.4: Display passive icons in level-up choices

**Test Criteria:**
- [ ] Stats increase correctly per passive level
- [ ] Stacking works with other systems

---

## System 6: Level-Up System

**XP Curve:** `xp_needed = 5 + (level - 1) * 5`

**Functional Requirements:**
- FR-6.1: XP bar fills when collecting gems
- FR-6.2: Level up pauses game (get_tree().paused = true)
- FR-6.3: Display 3 random choices from pool
- FR-6.4: Pool includes: weapons not at max (or NEW if slots available), passives not at max
- FR-6.5: Respect max 6 weapons when generating choices
- FR-6.6: Apply selected upgrade and resume game
- FR-6.7: Use tr() for all UI text

**Test Criteria:**
- [ ] Level up at correct XP amounts
- [ ] Choices respect max levels and slots
- [ ] Game pauses/resumes correctly

---

## System 7: Pickup System

**Pickup Values:**

| Enemy | XP Drop | Gold Drop |
|-------|---------|-----------|
| Green Duwende | 1 | 1 |
| Red Duwende | 3 | 2 |
| Santelmo | 4 | 3 |
| Manananggal | 50 | 100 |

**Functional Requirements:**
- FR-7.1: Pickup scene using Area2D
- FR-7.2: Spawn at enemy death location
- FR-7.3: 0.5s pause then magnetic drift toward player
- FR-7.4: Drift speed increases when within pickup_range
- FR-7.5: Pickup range modified by Magnetic Aura passive
- FR-7.6: Collection sound and floating "+1" text
- FR-7.7: Use object pooling

**Test Criteria:**
- [ ] Pickups spawn correctly
- [ ] Magnet effect works within range
- [ ] Passive increases pickup range

---

## System 8: Shop System

**Shop Upgrades:**

| Upgrade | Cost | Effect | Repeatable |
|---------|------|--------|------------|
| Damage | 100g | +2% base damage | ∞ |
| Max HP | 100g | +5 max HP | ∞ |
| Move Speed | 100g | +1% speed | ∞ |

**Functional Requirements:**
- FR-8.1: Shop screen displays current gold and upgrades
- FR-8.2: BUY button deducts gold and increments upgrade counter
- FR-8.3: Disable BUY when insufficient gold
- FR-8.4: Save shop data to user://save_data.json
- FR-8.5: Load shop data on game start
- FR-8.6: Apply bonuses at run start via GameState computed stats

**Test Criteria:**
- [ ] Purchase deducts gold correctly
- [ ] Upgrades persist across sessions
- [ ] Bonuses apply to next run

---

## System 9: Timer, Win/Lose, Results

**Functional Requirements:**
- FR-9.1: Timer displays top center, MM:SS format, counts up from 0:00
- FR-9.2: Victory at 30:00: pause, fade CanvasModulate to dawn, play crow sound
- FR-9.3: Defeat at HP=0: pause, death animation, show defeat screen
- FR-9.4: Results screen shows: time, enemies killed, score, gold earned
- FR-9.5: Buttons: Shop, Retry, Menu
- FR-9.6: Add gold_this_run to total gold on run end
- FR-9.7: Dawn transition: CanvasModulate from Color(0.6, 0.6, 0.8) to Color(1.0, 0.95, 0.9)

**Test Criteria:**
- [ ] Victory triggers at exactly 30:00
- [ ] Dawn effect transitions smoothly
- [ ] Gold adds to total correctly

---

## System 10: Endless Mode

**Functional Requirements:**
- FR-10.1: Locked on main menu until Story Mode beaten
- FR-10.2: Set endless_unlocked = true when Story Mode victory
- FR-10.3: Remove 30:00 win condition (timer continues indefinitely)
- FR-10.4: Continue spawn rate and stat scaling past 30:00
- FR-10.5: Track and save best_time_endless
- FR-10.6: Display best time on main menu and results

**Test Criteria:**
- [ ] Locked initially, unlocks after Story victory
- [ ] No victory at 30:00 in Endless
- [ ] Scaling continues past 30:00

---

## Dependency Chain

```
Phase 0 (Foundation):
  └── Project Setup

Phase 1 (Core):
  └── Player Characters ← Project Setup

Phase 2 (Combat):
  ├── Enemy System ← Player
  └── Weapon System ← Player, Enemies

Phase 3 (Progression):
  ├── Passive System ← Player, Weapons
  ├── Pickup System ← Enemies, Passives
  └── Level-Up System ← Weapons, Passives

Phase 4 (Meta):
  └── Shop System ← Pickups

Phase 5 (Game Flow):
  ├── Timer/Win/Lose ← Player, Enemies, Shop
  └── Endless Mode ← Timer/Win
```

---

## GameState Singleton Reference

```gdscript
# Persistent (saved)
var gold: int
var shop_damage: int
var shop_hp: int
var shop_speed: int
var endless_unlocked: bool
var shadow_unlocked: bool
var golden_unlocked: bool
var high_score_story: int
var high_score_endless: int
var best_time_endless: float

# Per-run (resets)
var current_hp: int
var max_hp: int
var current_xp: int
var level: int
var score: int
var gold_this_run: int
var time_survived: float
var weapons: Array  # [{id, level}]
var passives: Dictionary  # {id: level}
```

---

## Performance Requirements

- NFR-1: 60 FPS stable with 200+ enemies
- NFR-2: Object pooling for enemies, projectiles, pickups, particles
- NFR-3: Area2D for enemies (not CharacterBody2D)
- NFR-4: Spatial partitioning for collision optimization (64x64 grid cells)
- NFR-5: No queue_free() during gameplay - return to pool

---

## Art Sizes Reference

| Asset Type | Size |
|------------|------|
| Player/Enemies | 32x32 |
| Boss | 48x48 |
| Icons | 16x16 |
| Pickups | 16x16 |
| Projectiles | 16x16 or 8x8 |

---

*For full details on timeline, marketing, Steam setup, art requirements, and audio, see the master PRD at `.taskmaster/docs/prd.md`*

