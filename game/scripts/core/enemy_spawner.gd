extends Node

# References - set in Inspector
@export var player_path: NodePath 

# Enemy pool IDs
const GREEN_DUWENDE_POOL: String = "enemy_green_duwende"
const RED_DUWENDE_POOL: String = "enemy_red_duwende"

@onready var spawn_timer: Timer = $SpawnTimer

# Cached player reference
var player: Node2D

# Spawn configuration
const ARENA_WIDTH: int = 3072
const ARENA_HEIGHT: int = 2048
var spawn_dist: float = 450.0 # Base ring distance from player (ring = 405-495px)

func _ready() -> void:
	if player_path:
		player = get_node(player_path)


func _get_enemy_pool_id() -> String:
	# Pick which enemy type to spawn based on elapsed time
	var elapsed = GameTimer.elapsed_minutes

	# Before 8 Minutes: only green duwende
	if elapsed < 8.0:
		return GREEN_DUWENDE_POOL

	# After 8 minutes: 70% Green, 30% Red (Weighted random)
	var roll = randf() # Random number 0.0 to 1.0
	if roll < 0.7:
		return GREEN_DUWENDE_POOL
	else:
		return RED_DUWENDE_POOL


func spawn_enemy() -> void:
	if not GameTimer.is_gameplay_active():
		return

	var spawn_pos = _find_valid_spawn_pos()
	if spawn_pos == Vector2.INF:
		return

	var enemy = PoolManager.spawn(_get_enemy_pool_id())
	if not enemy:
		return

	enemy.global_position = spawn_pos
	enemy.initialize_stats(GameTimer.elapsed_minutes)

	var elapsed = GameTimer.elapsed_minutes
	spawn_timer.wait_time = SpawnManager.get_spawn_interval(elapsed)


func _find_valid_spawn_pos() -> Vector2:
	const MAX_ATTEMPTS = 8
	for _i in MAX_ATTEMPTS:
		var angle = randf() * TAU
		var offset = Vector2(cos(angle), sin(angle)) * spawn_dist * randf_range(0.9, 1.1)
		var pos = player.global_position + offset
		if pos.x >= 0 and pos.x <= ARENA_WIDTH and pos.y >= 0 and pos.y <= ARENA_HEIGHT:
			return pos
	return Vector2.INF
