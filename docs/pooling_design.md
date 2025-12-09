# Object Pooling System Design - Sarimanok Survivor

**Date:** 2025-12-09  
**Status:** Draft

---

## 1. Architecture Decision

### Chosen Approach: Hybrid (Central Manager + Per-Type Pools)

**Why:**

- **PoolManager (Singleton/Autoload)**: Single point of access from anywhere in the game
- **TypedPool (Internal)**: Each object type gets its own pool for clean separation
- **Benefits**: Easy to use (`PoolManager.spawn("enemy_duwende")`), flexible configuration per type

**Structure:**

```
PoolManager (Autoload)
├── enemy_pools: Dictionary<String, TypedPool>
├── projectile_pools: Dictionary<String, TypedPool>
├── pickup_pools: Dictionary<String, TypedPool>
└── particle_pools: Dictionary<String, TypedPool>
```

This balances convenience (single manager) with flexibility (type-specific configuration).

---

## 2. Public API

### PoolManager Methods

```gdscript
# Spawning - returns a pooled object, positioned and ready
func spawn(pool_id: String, position: Vector2 = Vector2.ZERO) -> Node

# Returning - deactivates and returns object to pool
func despawn(node: Node) -> void

# Preloading - call during loading screens or game start
func preload_pool(pool_id: String, count: int) -> void
func preload_all() -> void

# Stats - for debugging and optimization
func get_pool_stats(pool_id: String) -> Dictionary
func get_all_stats() -> Dictionary
```

### Usage Examples

```gdscript
# Spawning an enemy
var enemy = PoolManager.spawn("enemy_duwende", spawn_position)

# Spawning a projectile
var bullet = PoolManager.spawn("projectile_feather", player.position)
bullet.direction = aim_direction

# Despawning (call this instead of queue_free())
PoolManager.despawn(enemy)

# Preload during game start
func _ready():
    PoolManager.preload_all()
```

---

## 3. Configuration Model

### Pool Configuration Resource

Each pool type uses a `PoolConfig` resource for configuration:

```gdscript
# pool_config.gd
class_name PoolConfig
extends Resource

@export var pool_id: String              # Unique identifier (e.g., "enemy_duwende")
@export var scene_path: String           # Path to the scene to pool
@export var initial_size: int = 10       # Pre-allocated at startup
@export var max_size: int = 50           # Hard cap (0 = unlimited growth)
@export var can_grow: bool = true        # Allow spawning beyond initial_size
@export var parent_path: String = ""     # Node path for pooled objects (empty = PoolManager child)
```

### Default Configurations (from PRD)

| Pool ID        | Initial Size | Max Size | Can Grow |
| -------------- | ------------ | -------- | -------- |
| enemy\_\*      | 100          | 300      | true     |
| projectile\_\* | 100          | 200      | true     |
| pickup\_\*     | 200          | 500      | true     |
| particle\_\*   | 50           | 100      | true     |

### Registration

Pools are registered via a master configuration file:

```gdscript
# In PoolManager._ready() or via exported array
var pool_configs: Array[PoolConfig] = [
    preload("res://resources/pools/enemy_duwende_pool.tres"),
    preload("res://resources/pools/enemy_tikbalang_pool.tres"),
    preload("res://resources/pools/projectile_feather_pool.tres"),
    # ... etc
]
```

---

## 4. Required Interfaces for Pooled Objects

### Poolable Interface

All pooled objects must implement these methods:

```gdscript
# Called when object is spawned from pool
func on_spawn() -> void:
    pass  # Reset timers, enable processing, play spawn effects

# Called when object is returned to pool
func on_despawn() -> void:
    pass  # Stop movement, disable collision, hide visuals

# Reset object to default state (called before on_spawn)
func reset_state() -> void:
    pass  # Reset health, position, velocity, etc.
```

### Example Implementation (Enemy)

```gdscript
extends CharacterBody2D

var health: float
var max_health: float = 100.0

func reset_state() -> void:
    health = max_health
    velocity = Vector2.ZERO

func on_spawn() -> void:
    visible = true
    $CollisionShape2D.disabled = false
    set_physics_process(true)

func on_despawn() -> void:
    visible = false
    $CollisionShape2D.disabled = true
    set_physics_process(false)
```

### Example Implementation (Projectile)

```gdscript
extends Area2D

var direction: Vector2 = Vector2.RIGHT
var speed: float = 500.0
var damage: float = 10.0
var lifetime: float = 2.0
var _timer: float = 0.0

func reset_state() -> void:
    direction = Vector2.RIGHT
    _timer = 0.0

func on_spawn() -> void:
    visible = true
    $CollisionShape2D.disabled = false
    set_physics_process(true)

func on_despawn() -> void:
    visible = false
    $CollisionShape2D.disabled = true
    set_physics_process(false)

func _physics_process(delta: float) -> void:
    position += direction * speed * delta
    _timer += delta
    if _timer >= lifetime:
        PoolManager.despawn(self)
```

---

## 5. Migration Plan

### Current State

Per the audit (2025-12-09):

- **No existing pooling code** - clean slate
- **No spawn/despawn patterns** - nothing to migrate
- **No legacy code** - all new systems will use pooling from day one

### Implementation Order

1. **Phase 1: Core Infrastructure**

   - Create `PoolConfig` resource class
   - Create `TypedPool` internal class
   - Create `PoolManager` autoload
   - Add to Project Settings → Autoload

2. **Phase 2: First Integration (Enemies)**

   - Create pool configs for enemy types
   - Update enemy spawner to use `PoolManager.spawn()`
   - Update enemy death to use `PoolManager.despawn()`

3. **Phase 3: Weapons & Projectiles**

   - Create pool configs for projectile types
   - Update weapon scripts to use pooling

4. **Phase 4: Pickups & Particles**
   - Create pool configs for pickup types
   - Create pool configs for particle types
   - Update drop systems to use pooling

### Rules Going Forward

- **NEVER use `instantiate()` for gameplay objects** - always use `PoolManager.spawn()`
- **NEVER use `queue_free()` for pooled objects** - always use `PoolManager.despawn()`
- **All pooled objects must implement** `reset_state()`, `on_spawn()`, `on_despawn()`

---

## 6. File Structure

```
game/
├── autoloads/
│   └── pool_manager.gd          # Central manager (Autoload)
├── resources/
│   ├── pool_config.gd           # Resource class definition
│   └── pools/                   # Pool configuration resources
│       ├── enemy_duwende_pool.tres
│       ├── enemy_tikbalang_pool.tres
│       ├── projectile_feather_pool.tres
│       └── ...
└── scripts/
    └── pooling/
        └── typed_pool.gd        # Internal pool implementation
```

---

## 7. Performance Targets

From PRD requirements:

| Metric                          | Target                      |
| ------------------------------- | --------------------------- |
| Total pre-allocated enemies     | 300                         |
| Total pre-allocated projectiles | 200                         |
| Total pre-allocated pickups     | 500                         |
| Particles per type              | 100                         |
| Spawn time                      | < 1ms (no instantiate)      |
| Memory overhead                 | Acceptable for 60fps target |

---

## 8. Debug Features (Nice to Have)

- Pool stats overlay showing active/available counts
- Warning when pool runs empty and has to grow
- Logging for spawn/despawn events in debug builds
