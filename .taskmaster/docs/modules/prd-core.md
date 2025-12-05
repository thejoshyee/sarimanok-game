# Sarimanok Survivor - Core Foundation (Weeks 1-3)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Inspiration:** Vampire Survivors + Filipino mythology
- **Timeline:** 14 weeks → Early Access launch ~March 8, 2026
- **Price:** $2.99-4.99

**What is Sarimanok?**
The Sarimanok is a legendary bird from the folklore of the Maranao people of Mindanao, Philippines. It symbolizes good fortune, prosperity, and royalty. Depicted as a colorful bird with elaborate, intricate designs, it's often shown with a fish in its beak—representing offerings to the spirit world. The Sarimanok serves as a spiritual link between the seen and unseen worlds, making it the perfect guardian against creatures of darkness.

This milestone establishes the core survivor gameplay loop: move, auto-attack, dodge enemies, collect XP, level up, and get stronger. By the end of Week 3, you'll have a playable roguelite with Classic Sarimanok, 2 enemy types (Green/Red Duwende), 6 weapons, 4 passives, and the progression loop.

## Dependencies

- None (this is the foundation)

## Deferred to Later Milestones

- **Shadow & Golden Sarimanok** → Week 6
- **Santelmo & Manananggal enemies** → Week 4
- **Win condition (30:00 dawn)** → Week 4
- **Shop system** → Week 5

---

# Technical Specifications

## Engine & Version

- **Godot 4.x** (latest stable)
- GDScript (not C#)

## Target Performance

| Metric            | Target           |
| ----------------- | ---------------- |
| FPS               | 60 stable        |
| Enemies on screen | 200+ without lag |
| Load time         | < 3 seconds      |
| File size         | < 200 MB         |

## Resolution

- **Viewport:** 640×360 pixels (what camera shows)
- **Window:** Scales to player's monitor (3× for 1080p, 4× for 1440p)
- **Arena:** 1920×1088 pixels (60×34 tiles)
- **Tile size:** 32×32 pixels

**Godot Project Settings:**

```
Display → Window:
  Viewport Width: 640
  Viewport Height: 360
  Stretch Mode: canvas_items
  Stretch Aspect: keep
```

## Controls

| Input         | Action          |
| ------------- | --------------- |
| WASD / Arrows | Move            |
| ESC           | Pause           |
| Mouse         | Menu navigation |
| Click         | Select          |

## Input Action Mapping (Godot Project Settings)

Configure these in Project Settings > Input Map before coding begins:

| Action Name | Primary Key | Secondary Key | Controller                     |
| ----------- | ----------- | ------------- | ------------------------------ |
| move_up     | W           | Up Arrow      | D-pad Up / Left Stick Up       |
| move_down   | S           | Down Arrow    | D-pad Down / Left Stick Down   |
| move_left   | A           | Left Arrow    | D-pad Left / Left Stick Left   |
| move_right  | D           | Right Arrow   | D-pad Right / Left Stick Right |
| pause       | Escape      | —             | Start Button                   |
| ui_accept   | Enter       | Space         | A Button (Xbox) / Cross (PS)   |
| ui_cancel   | Escape      | —             | B Button (Xbox) / Circle (PS)  |

**Usage in code:**

```gdscript
func _process(delta):
    var input_vector = Vector2.ZERO
    input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
    input_vector = input_vector.normalized()

    velocity = input_vector * move_speed
    move_and_slide()
```

**Note:** Using `get_action_strength()` instead of `is_action_pressed()` allows analog stick support for smooth movement.

## Performance Architecture

### Object Pooling

Pre-allocate pools at game start to avoid runtime instantiation:

| Pool            | Size         | Purpose                    |
| --------------- | ------------ | -------------------------- |
| Enemy pool      | 300          | Reuse enemy instances      |
| Projectile pool | 200          | Feathers, fireballs        |
| Pickup pool     | 500          | XP gems + Gold coins       |
| Particle pool   | 100 per type | Death effects, hit effects |

**Rules:**

- Never use `queue_free()` during gameplay - return to pool instead
- Never instantiate during gameplay - pull from pool
- Pre-warm pools in `_ready()` of main scene

```gdscript
# Example pool pattern
var enemy_pool: Array[Enemy] = []
const POOL_SIZE = 300

func _ready():
    for i in POOL_SIZE:
        var enemy = enemy_scene.instantiate()
        enemy.set_process(false)
        enemy.visible = false
        enemy_pool.append(enemy)
        add_child(enemy)

func spawn_enemy() -> Enemy:
    for enemy in enemy_pool:
        if not enemy.active:
            enemy.activate()
            return enemy
    return null  # Pool exhausted
```

### Spatial Partitioning

With 200+ enemies, naive collision checks become O(n²). Use grid-based spatial hashing:

- Grid cell size: 64x64 pixels (2x enemy size)
- Only check collisions between entities in same/adjacent cells
- Update entity grid position when they move cells, not every frame

```gdscript
# Grid-based spatial hash
var spatial_grid: Dictionary = {}  # Vector2i -> Array[Enemy]
const CELL_SIZE = 64

func get_cell(pos: Vector2) -> Vector2i:
    return Vector2i(int(pos.x / CELL_SIZE), int(pos.y / CELL_SIZE))

func get_nearby_enemies(pos: Vector2) -> Array[Enemy]:
    var cell = get_cell(pos)
    var nearby: Array[Enemy] = []
    for dx in range(-1, 2):
        for dy in range(-1, 2):
            var check_cell = cell + Vector2i(dx, dy)
            if spatial_grid.has(check_cell):
                nearby.append_array(spatial_grid[check_cell])
    return nearby
```

### Performance Milestones

| Week   | Test        | Target        |
| ------ | ----------- | ------------- |
| Week 3 | 100 enemies | 60 FPS stable |

---

# Feature 1: Player Character - Classic Sarimanok

**What It Does:**
You control the Sarimanok with WASD/arrow keys. Weapons attack automatically—you just focus on positioning and dodging.

## Base Stats

| Stat         | Base Value | Notes                           |
| ------------ | ---------- | ------------------------------- |
| Max HP       | 100        | Modified by character choice    |
| Move Speed   | 200        | Pixels per second               |
| Damage       | 100%       | Multiplier for all weapons      |
| Attack Speed | 100%       | Multiplier for weapon cooldowns |
| Pickup Range | 50         | Pixels, for XP/Gold collection  |

**Controls:**

- WASD or Arrow Keys: Move
- ESC: Pause menu
- NO attack button (weapons are automatic)

**Animation:**

- 2 frames: idle/walk (bob animation)
- Flip sprite based on movement direction (code handles this)
- 32x32 pixel sprite

## Technical Requirements

- CharacterBody2D with 8-directional movement
- Sprite flips horizontally based on velocity.x
- 2-frame animation (frame 1 ↔ frame 2 every 0.2s while moving)
- Collision shape for enemy damage detection
- Invincibility frames (0.5s) after taking damage

## Placeholder Art (Week 1-3)

Classic Sarimanok placeholder: ColorRect, multicolor/rainbow, 32x32

---

# Feature 2: Enemy System

**What It Does:**
Enemies spawn at screen edges, walk toward the player, and deal damage on contact. Killing enemies drops XP and Gold.

## Enemy Roster (2 for Weeks 1-3)

| Enemy             | HP  | Damage | Speed | Spawns At | Behavior         |
| ----------------- | --- | ------ | ----- | --------- | ---------------- |
| **Green Duwende** | 10  | 5      | 80    | 0:00+     | Walks to player  |
| **Red Duwende**   | 25  | 10     | 100   | 8:00+     | Faster, stronger |

**Note:** Santelmo and Manananggal deferred to Week 4.

## Duwende Color Variants

In Filipino folklore, duwendes have different ranks/types indicated by color:

- **Green:** Common, mischievous
- **Red:** More aggressive, territorial

This is culturally authentic AND saves art time (recolor same sprite).

## Difficulty Scaling

Enemy stats scale over time to create late-game challenge:

```gdscript
# Enemy stat scaling - add to spawn manager
func get_scaled_hp(base_hp: int, elapsed_minutes: float) -> int:
    # +5% HP per 5 minutes
    var scale = 1.0 + (elapsed_minutes / 5.0) * 0.05
    return int(base_hp * scale)

func get_scaled_damage(base_damage: int, elapsed_minutes: float) -> int:
    # +3% damage per 5 minutes
    var scale = 1.0 + (elapsed_minutes / 5.0) * 0.03
    return int(base_damage * scale)
```

| Time  | Green HP | Green Dmg | Red HP | Red Dmg |
| ----- | -------- | --------- | ------ | ------- |
| 0:00  | 10       | 5         | -      | -       |
| 10:00 | 11       | 5         | 27     | 10      |
| 20:00 | 12       | 6         | 30     | 11      |

## Enemy Behaviors

**Duwende (All Colors):**

```
Every frame:
  direction = (player.position - self.position).normalized()
  velocity = direction * speed
  move_and_slide()

On contact with player:
  player.take_damage(damage)
```

**Enemy Collision Rules:**

- Enemies pass through each other (no inter-enemy collision)
- This is intentional for performance and gameplay (allows swarming)
- Enemies DO collide with player (deal damage on overlap)
- Enemies DO NOT collide with arena boundaries (spawn outside, walk in)

## Spawn System

**Spawn Location:** Random point on screen edge (just outside visible area)

**Spawn Timeline (Weeks 1-3):**
| Time | Enemies Spawning | Spawn Rate |
| --------- | ---------------- | ------------------- |
| 0:00-8:00 | Green Duwende | 1 per 2s → 1 per 1s |
| 8:00+ | Green + Red | 1 per 1s → 0.8s |

**Spawn Rate Formula:**

```gdscript
# Exponential difficulty scaling - spawns increase 5% per minute
var base_spawn_interval = 2.0  # seconds between spawns at 0:00
var difficulty_scale = 1.05    # 5% faster spawns per minute

func get_spawn_interval(elapsed_minutes: float) -> float:
    return base_spawn_interval / pow(difficulty_scale, elapsed_minutes)

# Examples:
# 0:00  = 2.0s between spawns
# 5:00  = 1.57s between spawns
# 10:00 = 1.23s between spawns
```

## Enemy Drops

| Enemy         | XP Drop | Gold Drop |
| ------------- | ------- | --------- |
| Green Duwende | 1       | 1         |
| Red Duwende   | 3       | 2         |

## Technical Requirements

- Enemy scene with **Area2D** (NOT CharacterBody2D - see note below)
- Simple pathfinding (just move toward player)
- Spawn manager that tracks time and spawn rates
- Object pooling for performance (reuse enemy instances)
- Death: Play particle effect, drop XP gem + Gold coin, return to pool

**Why Area2D instead of CharacterBody2D:** Enemies only need to move toward the player (simple vector math) and detect overlap for damage. CharacterBody2D includes physics overhead (collision response, move_and_slide) that tanks FPS with 200+ enemies on screen. Area2D is lightweight and sufficient for our needs.

## Placeholder Art (Week 1-3)

- Green Duwende: ColorRect, green, 32x32
- Red Duwende: ColorRect, red, 32x32

---

# Feature 3: Weapon System

**What It Does:**
Weapons attack automatically on a cooldown. Player collects weapons through level-up choices. Each weapon has different behavior and can be upgraded.

## Weapon Roster (6 Total: 4 Unique + 2 Clones)

| Weapon              | Type       | Behavior                         | Cooldown | Base Damage |
| ------------------- | ---------- | -------------------------------- | -------- | ----------- |
| **Peck**            | Melee      | Quick jab in facing direction    | 0.5s     | 10          |
| **Wing Slap**       | AOE        | Circle around player             | 1.5s     | 8           |
| **Feather Shot**    | Projectile | Shoots feather at nearest enemy  | 1.0s     | 12          |
| **Spiral Feathers** | Orbital    | 4 feathers orbit player          | Passive  | 6           |
| **Ice Shard**       | Projectile | Slow feather + enemy slow debuff | 1.2s     | 10          |
| **Flame Wing**      | AOE        | Smaller, stronger AOE circle     | 1.5s     | 10          |

## Weapon Descriptions

**Peck (Starting Weapon):**

- Short range melee attack
- Damages enemies in small cone in front of player
- Fast attack speed
- Player always starts with this

**Wing Slap:**

- Damages ALL enemies in radius around player
- Larger area than Peck
- Slower cooldown
- Great for crowds

**Feather Shot:**

- Shoots feather projectile toward nearest enemy
- Travels across screen
- Pierces through 1 enemy (at level 1)
- Good for ranged threats

**Spiral Feathers:**

- 4 feathers orbit the player constantly
- Damages enemies on contact
- No cooldown (always active)
- Great for close-range protection
- Reuses Feather Shot projectile sprite (rotated)

## Weapon Levels

Each weapon can be upgraded to Level 5 through level-up choices:

**Peck Upgrades:**
| Level | Damage | Effect |
| ----- | ------ | ---------------------- |
| 1 | 10 | Base |
| 2 | 15 | +50% damage |
| 3 | 20 | +100% damage |
| 4 | 25 | Faster cooldown (0.4s) |
| 5 | 35 | Hits in wider arc |

**Wing Slap Upgrades:**
| Level | Damage | Effect |
| ----- | ------ | ------------------ |
| 1 | 8 | Base |
| 2 | 12 | +50% damage |
| 3 | 16 | Larger radius |
| 4 | 20 | +150% damage |
| 5 | 28 | Even larger radius |

**Feather Shot Upgrades:**
| Level | Damage | Effect |
| ----- | ------ | ------------------------- |
| 1 | 12 | 1 feather |
| 2 | 14 | 2 feathers |
| 3 | 16 | 3 feathers |
| 4 | 18 | Feathers pierce 2 enemies |
| 5 | 24 | 4 feathers, pierce 3 |

**Spiral Feathers Upgrades:**
| Level | Damage | Effect |
| ----- | ------ | ------------------------ |
| 1 | 6 | 4 orbiting feathers |
| 2 | 8 | +33% damage |
| 3 | 10 | Faster rotation speed |
| 4 | 12 | 6 orbiting feathers |
| 5 | 16 | 8 feathers, larger orbit |

## Maximum Weapons

Player can hold up to **6 weapons** at once.

If you have 6 weapons and level up, you'll only see upgrade options for existing weapons ("+1" options), not new weapons.

## Clone Weapons (2 Additional - Low-Cost Variety)

To increase build variety without scope explosion, add 2 "clone" weapons that reuse existing weapon logic with different stats/visuals:

| Clone Weapon   | Base Weapon  | Visual Change | Stat Change                                   |
| -------------- | ------------ | ------------- | --------------------------------------------- |
| **Ice Shard**  | Feather Shot | Blue feather  | Slower projectile + 0.5s slow debuff on enemy |
| **Flame Wing** | Wing Slap    | Orange AOE    | +20% damage, smaller radius                   |

**Ice Shard:**

- Reuses Feather Shot projectile logic
- Blue-tinted feather sprite (recolor)
- Slower projectile speed (100 vs 150)
- Applies 0.5s slow debuff to hit enemies (50% speed reduction)
- Great for kiting and crowd control

**Flame Wing:**

- Reuses Wing Slap AOE logic
- Orange/red AOE effect (recolor)
- +20% damage (10 base vs 8)
- 75% radius of Wing Slap
- Higher risk/reward for aggressive players

## Data-Driven Weapon Architecture

To make adding weapons trivial (10-15 minutes per weapon), use Godot Resources:

```gdscript
# weapons/weapon_data.gd - Data-driven weapon definitions
class_name WeaponData
extends Resource

@export var id: String
@export var display_name: String
@export var description: String
@export var base_damage: int
@export var cooldown: float
@export var weapon_type: String  # "projectile", "aoe", "melee", "orbital"
@export var sprite: Texture2D
@export var icon: Texture2D
@export var upgrades: Array[Dictionary]  # [{level, damage, effect_description}]

# Optional modifiers (for clones and variants)
@export var debuff_type: String = ""  # "slow", "burn", etc.
@export var debuff_duration: float = 0.0
@export var debuff_strength: float = 0.0  # e.g., 0.5 = 50% slow
@export var radius_modifier: float = 1.0
@export var speed_modifier: float = 1.0
@export var projectile_count: int = 1
@export var pierce_count: int = 1
```

**Benefits:**

- New weapons = create `.tres` resource file, no code changes
- Clone weapons share base weapon's script, just different data
- Easy to balance (tweak numbers in Inspector, no recompile)
- Update 1 weapon additions become trivial

## Technical Requirements

- Weapon base class with cooldown timer
- Each weapon type extends base class
- Weapon manager tracks equipped weapons
- Weapons fire automatically when cooldown ready
- Visual effects for each weapon attack
- Damage detection using Area2D
- **WeaponData Resource for data-driven definitions**
- **Debuff system for slow/burn effects (used by clone weapons)**

## Placeholder Art (Week 1-3)

All weapons use ColorRect placeholders or simple shapes during Weeks 1-3.

---

# Feature 4: Passive System

**What It Does:**
Passives are stat boosts that stack. Collect them through level-up choices. No animation or visual effect—just numbers.

## Passive Roster (4 Total)

| Passive           | Per Level         | Max Level | At Max             |
| ----------------- | ----------------- | --------- | ------------------ |
| **Iron Beak**     | +10% Damage       | 5         | +50% total damage  |
| **Thick Plumage** | +15 Max HP        | 5         | +75 HP             |
| **Racing Legs**   | +10% Move Speed   | 5         | +50% move speed    |
| **Magnetic Aura** | +20% Pickup Range | 5         | +100% pickup range |

## How Passives Stack

**Example: Iron Beak**

- Level 1: All weapons deal 110% damage
- Level 2: All weapons deal 120% damage
- Level 3: All weapons deal 130% damage
- Level 4: All weapons deal 140% damage
- Level 5: All weapons deal 150% damage

**These multiply with weapon upgrades!**

Peck Level 5 (35 damage) + Iron Beak Level 5 (150%):

```
35 × 1.50 = 52.5 damage per hit
```

## Technical Requirements

- Simple stat modifiers in player script
- Passive manager tracks levels
- Apply modifiers to relevant calculations
- Only needs icon art (16x16)

---

# Feature 5: Level-Up System

**What It Does:**
Collecting XP fills a bar. When full, game pauses and presents 3 random upgrade choices. Player picks one, game resumes.

## XP Curve

| Level | XP Required  | Cumulative |
| ----- | ------------ | ---------- |
| 1→2   | 5            | 5          |
| 2→3   | 10           | 15         |
| 3→4   | 15           | 30         |
| 4→5   | 20           | 50         |
| 5→6   | 25           | 75         |
| ...   | +5 per level | ...        |

Formula: `xp_needed = 5 + (level - 1) * 5`

## Level-Up Screen

```
┌─────────────────────────────────────────────┐
│              LEVEL UP!                      │
├─────────────────────────────────────────────┤
│                                             │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐     │
│  │  PECK   │  │  WING   │  │  IRON   │     │
│  │   +1    │  │  SLAP   │  │  BEAK   │     │
│  │ Lv.1→2  │  │  NEW!   │  │  NEW!   │     │
│  └─────────┘  └─────────┘  └─────────┘     │
│                                             │
│         Click to choose one                 │
└─────────────────────────────────────────────┘
```

## Choice Pool Logic

The pool contains:

- All weapons not yet at max level (or not owned + slot available)
- All passives not yet at max level (or not owned)

**Example scenarios:**

_Early game (Level 2, only have Peck):_

- Pool: Peck+1, Wing Slap (NEW), Feather Shot (NEW), Iron Beak, Thick Plumage, Racing Legs
- Show 3 random from pool

_Mid game (Have all 6 weapons):_

- Pool: Peck+1, Wing Slap+1, Feather Shot+1, Iron Beak+1, Thick Plumage+1, Racing Legs+1
- No "NEW" weapons (slots full)

_Late game (Peck maxed):_

- Pool excludes Peck entirely
- Only shows upgradeable items

## Technical Requirements

```gdscript
func _on_xp_collected(amount):
    current_xp += amount
    if current_xp >= xp_to_next_level:
        current_xp -= xp_to_next_level
        level += 1
        xp_to_next_level = calculate_xp_needed(level)
        show_level_up_screen()

func show_level_up_screen():
    get_tree().paused = true
    var choices = get_random_choices(3)
    level_up_ui.display(choices)

func _on_choice_selected(choice):
    apply_upgrade(choice)
    get_tree().paused = false
```

---

# Feature 6: Pickup System

**What It Does:**
Enemies drop XP gems and Gold coins. Player walks over them to collect.

## Pickup Types

| Pickup        | Visual                | Effect                 |
| ------------- | --------------------- | ---------------------- |
| **XP Gem**    | Blue diamond (16x16)  | Adds to XP bar         |
| **Gold Coin** | Yellow circle (16x16) | Adds to permanent gold |

## Pickup Behavior

- Spawns at enemy death location
- Sits still for 0.5s (brief pause)
- Then slowly drifts toward player (magnetic effect)
- Collected when touching player hitbox
- Collection range increased by Magnetic Aura passive

## Magnet Effect

```gdscript
func _process(delta):
    var distance = global_position.distance_to(player.global_position)
    if distance < player.pickup_range:
        var direction = (player.global_position - global_position).normalized()
        global_position += direction * magnet_speed * delta
```

## Technical Requirements

- Pickup scene (Area2D with sprite)
- Spawned by enemy on death
- Magnetic drift toward player when close
- Collected on overlap with player
- Play collect sound
- Show "+1" floating text (nice-to-have)

## Placeholder Art (Week 1-3)

- XP Gem: ColorRect, blue, 16x16
- Gold Coin: ColorRect, yellow, 16x16

---

# Week 1: The Core Loop

**End State: "I can play a survivor game"**

What's playable at end of week:

- Sarimanok moves with WASD in a bounded arena
- Peck attack fires automatically
- Green Duwendes spawn and walk toward player
- Duwendes die when hit, drop XP gem (placeholder)
- Player dies when HP = 0
- Game over screen shows "You died"

## Tasks

- [ ] Create project structure
- [ ] Set up project settings (640×360 viewport, canvas_items stretch)
- [ ] **Set up Audio buses in Project Settings (Master, Music, SFX) - do this Day 1, takes 5 minutes, prevents hours of headache later**
- [ ] **Configure Input Map in Project Settings**: Map 'Spacebar' and 'Gamepad A' to 'ui_accept' (makes controller support free/automatic).
- [ ] Create TileMap with placeholder tileset (simple colored squares)
- [ ] Paint basic 60×34 arena with placeholder tiles
- [ ] Set up Camera2D with limits (0,0 to 1920,1088)
- [ ] Add invisible boundary collision (StaticBody2D)
- [ ] Implement player movement (WASD) using `Input.get_action_strength()` for analog support
- [ ] Create placeholder Sarimanok sprite (colored rectangle 32x32)
- [ ] Implement Peck attack (auto-fire, cooldown)
- [ ] Create placeholder Duwende (green rectangle 32x32)
- [ ] Duwende walks toward player
- [ ] Duwende takes damage from Peck
- [ ] Duwende dies and drops placeholder XP gem
- [ ] Player takes damage from enemy contact
- [ ] Player dies at 0 HP, shows game over
- [ ] **Use `tr()` function for all UI text strings (localization prep - costs nothing now)**
- [ ] **Create `localization/translations.csv` with initial UI strings (30 min - enables community translations later)**

**Integration Test:** Can you survive for 60 seconds dodging and pecking?

---

# Week 2: Progression Loop

**End State: "I can level up and get stronger"**

Builds on Week 1, adds:

- XP gems are collected and fill XP bar
- Level up pauses game, shows 3 choices
- Choices: Peck +1, Wing Slap (new), Iron Beak (new)
- Wing Slap weapon works (AOE circle)
- Iron Beak passive increases damage
- Red Duwende spawns (recolor, higher stats)
- Timer shows on screen (counts up)

## Tasks

- [ ] XP gem pickup works
- [ ] XP bar UI displays
- [ ] Level up triggers at threshold
- [ ] Level up screen pauses game
- [ ] Display 3 random choices (placeholder buttons)
- [ ] Clicking choice applies upgrade and resumes game
- [ ] Wing Slap weapon (AOE circle around player)
- [ ] Iron Beak passive (damage boost)
- [ ] Add Red Duwende (recolor, different stats)
- [ ] Timer displays on screen
- [ ] Enemy stat scaling (HP/damage increase over time)
- [ ] **Placeholder SFX: Peck attack sound (use BFXR or free sound pack)**
- [ ] **Placeholder SFX: Enemy hit sound**
- [ ] **Placeholder SFX: XP pickup sound**

**Integration Test:** Can you reach level 10 with 2 weapons + 1 passive?

---

# Week 3: Full Arsenal + Data-Driven Architecture

**End State: "I can build different weapon combos with scalable architecture"**

Builds on Week 2, adds:

- Feather Shot weapon (projectile toward nearest enemy)
- All 4 passives working (Thick Plumage, Racing Legs, Magnetic Aura)
- All weapons/passives upgrade to level 5
- **Data-driven WeaponData Resource system**
- **2 Clone weapons (Ice Shard, Flame Wing) for build variety**
- **Damage numbers on enemy hit (debugging tool)**
- **Enemy damage flash (white flash on hit)**

## Tasks

- [ ] Feather Shot weapon (projectile)
- [ ] Thick Plumage passive (+HP)
- [ ] Racing Legs passive (+speed)
- [ ] **Spiral Feathers weapon (4 feathers orbit player, damage on contact)**
- [ ] **Magnetic Aura passive (+20% pickup range per level, max 5 = +100%)**
- [ ] **WeaponData Resource class (data-driven weapon definitions)**
- [ ] **Debuff system (slow effect for Ice Shard)**
- [ ] **Ice Shard clone weapon (blue Feather Shot + 0.5s slow debuff)**
- [ ] **Flame Wing clone weapon (orange Wing Slap, +20% damage, smaller radius)**
- [ ] Weapon upgrades to level 5 work
- [ ] Passive upgrades to level 5 work
- [ ] Max 6 weapons enforced in level-up pool
- [ ] Level-up pool includes all weapons/passives correctly
- [ ] **Damage numbers (floating text on enemy hit - CRITICAL for balance testing)**
- [ ] **Enemy damage flash (white flash on hit - game feel)**
- [ ] **Placeholder SFX: Wing Slap sound**
- [ ] **Placeholder SFX: Feather Shot sound**
- [ ] **Placeholder SFX: Spiral Feathers sound**
- [ ] **Placeholder SFX: Enemy death sound**
- [ ] **Placeholder SFX: Gold pickup sound**

**Integration Test:** Can you max out 6 weapons and 4 passives in one run? Do damage numbers appear on hits?

---

# Definition of Done (Weeks 1-3)

## Core Gameplay

- [ ] Player moves in all 8 directions
- [ ] Player takes damage from enemies
- [ ] Player dies at 0 HP
- [ ] Peck attack damages enemies
- [ ] Wing Slap damages nearby enemies
- [ ] Feather Shot fires projectiles
- [ ] Spiral Feathers orbit and damage enemies
- [ ] Ice Shard slows enemies
- [ ] Flame Wing is smaller AOE with higher damage
- [ ] All weapons auto-fire correctly
- [ ] Weapons upgrade through level-ups
- [ ] Passives boost stats correctly (Iron Beak, Thick Plumage, Racing Legs, Magnetic Aura)

## Enemies

- [ ] Green Duwende spawns and walks toward player
- [ ] Red Duwende is stronger than Green
- [ ] All enemies drop XP and Gold
- [ ] Spawn rate increases over time
- [ ] Enemy stat scaling works (HP/damage increase over time)

## Progression

- [ ] XP collected fills bar
- [ ] Level up pauses game
- [ ] 3 choices displayed
- [ ] Choice applies correctly
- [ ] Game resumes after choice
- [ ] Gold persists after run ends

## Technical

- [ ] 60 FPS with 100+ enemies
- [ ] No memory leaks (long runs)
- [ ] No console errors
- [ ] Damage numbers appear on hits
- [ ] Enemy flash when hit
- [ ] Placeholder SFX for game feel

---

**Next Milestone:** Week 4-5 (Win Condition & Shop System) - See `prd-progression.md`
