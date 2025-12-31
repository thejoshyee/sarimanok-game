extends Node

# References - set in Inspector
@export var player_path: NodePath
@export var enemy_pool_id: String = "enemy_test"  # Pool ID instead of scene

# Cached player reference
var player: Node2D

# Spawn configuration
const ARENA_WIDTH: int = 3072
const ARENA_HEIGHT: int = 2048
var spawn_dist: float = 465.0  # Ring distance from player

# Spawn timing
var spawn_timer: float = 0.0
var spawn_interval: float = 3.0

func _ready() -> void:
	if player_path:
		player = get_node(player_path)


func _process(delta: float) -> void:
	if not player:
		return
	
	# Spawn enemies on timer
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_enemy()


func spawn_enemy() -> void:
	var enemy = PoolManager.spawn(enemy_pool_id)
	if not enemy:
		return
	
	# Calculate spawn position using polar coordinates
	# WHY: Ring spawn ensures enemies come from all directions, just off-screen
	var angle = randf() * TAU  # Random angle (0 to 2π)
	var offset = Vector2(cos(angle), sin(angle)) * spawn_dist
	var spawn_pos = player.global_position + offset
	
	# Clamp to arena bounds (TODO: Refine this)
	spawn_pos.x = clamp(spawn_pos.x, 0, ARENA_WIDTH)
	spawn_pos.y = clamp(spawn_pos.y, 0, ARENA_HEIGHT)
	
	enemy.global_position = spawn_pos
	enemy.initialize_stats(GameTimer.elapsed_minutes)
