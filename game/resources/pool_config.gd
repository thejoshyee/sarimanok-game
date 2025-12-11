#pool_config.gd
# Resource that defines how a specific pool should behave
class_name PoolConfig
extends Resource

@export var pool_id: String = ""              # Unique identifier (e.g., "enemy_duwende")
@export var scene_path: String = ""           # Path to the scene to pool
@export var initial_size: int = 10            # Pre-allocated at startup
@export var max_size: int = 50                # Hard cap (0 = unlimited growth)
@export var can_grow: bool = true             # Allow spawning beyond initial_size