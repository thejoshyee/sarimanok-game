extends Node

# Arena dimensions - must match Main.gd constants
const ARENA_WIDTH: int = 3072
const ARENA_HEIGHT: int = 2048
const SPAWN_OFFSET: int = 48  # How far outside arena to spawn enemies

# Reference for spawning - set in Inspector
@export var player_path: NodePath
@export var enemy_scene: PackedScene

# Cached player reference
var player: Node2D

# Spawn distance - ring around player (viewport diagonal/2 + padding)
# WHY: Enemies spawn just outside visible area, ~465px from player
var spawn_dist: float = 465.0

func _ready() -> void:
	# Convert NodePath to actual node reference
	# WHY: NodePath is just a string - we need the real node to use it
	print("Player path: ", player_path)
	if player_path:
		player = get_node(player_path)


# Calculate scaled HP based on elapsed time
# WHY: Enemies get 5% more HP every 5 minutes for progressive difficulty
# base_hp: Starting HP value for this enemy type
# elapsed_minutes: How many minutes into the run
func get_scaled_hp(base_hp: int, elapsed_minutes: float) -> int:
	var scale = 1.0 + (elapsed_minutes / 5.0) * 0.05 # +5% per 5min
	return int(base_hp * scale)

# Calculate scaled damage based on elapsed time
# WHY: Enemies deal 3% more damage every 5 minutes (slower than HP scaling)
# base_damage: starting damage value for this enemy type
# elapsed_minutes: How many minutes into the run
func get_scaled_damage(base_damage: int, elapsed_minutes: float) -> int:
	var scale = 1.0 + (elapsed_minutes / 5.0) * 0.03 # +3% per 5min
	return int(base_damage * scale)


# Helper to get current game time from global timer
func get_elapsed_minutes() -> float:
	return GameTimer.elapsed_minutes


# Get a random spawn position at arena edges
# WHY: Enemies should spawn just outside the visible arena and walk in
# Returns: Vector2 position just outside one of the four arena edges
func get_edge_spawn_position() -> Vector2:
	# Pick a random edge (0=top, 1=bottom, 2=left, 3=right)
	var edge = randi() % 4

	match edge:
		0:  # Top edge
			return Vector2(randf_range(0, ARENA_WIDTH), -SPAWN_OFFSET)
		1:  # Bottom edge
			return Vector2(randf_range(0, ARENA_WIDTH), ARENA_HEIGHT + SPAWN_OFFSET)
		2:  # Left edge
			return Vector2(-SPAWN_OFFSET, randf_range(0, ARENA_HEIGHT))
		3:  # Right edge
			return Vector2(ARENA_WIDTH + SPAWN_OFFSET, randf_range(0, ARENA_HEIGHT))
		_:
			return Vector2.ZERO
