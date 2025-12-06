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

**Related Files:**
- [Enemy System](prd-core-enemies.md) - Feature 2
- [Weapon System](prd-core-weapons.md) - Feature 3
- [Progression Systems](prd-core-progression.md) - Features 4-6, Week 1-3 tasks



