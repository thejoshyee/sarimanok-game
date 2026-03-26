extends Area2D

# How much XP this gem gives when collected
@export var xp_value: int = 10

# Magnetic drift settings
var pickup_range: float = 64.0   # Base range to start drifting toward player
var magnet_speed: float = 100.0  # How fast the gem flies toward the player
var is_being_attracted: bool = false

func _process(delta: float) -> void:
	# Find the player
	var players = get_tree().get_nodes_in_group("player")
	if players.is_empty():
		return
	var player = players[0]
	
	# Calculate effective magnetic range (base × Magnetic Aura modifier)
	var effective_range = pickup_range * PassiveManager.get_modifier("magnetic_aura")
	var distance = global_position.distance_to(player.global_position)
	
	# If within magnetic range, drift toward player
	if distance < effective_range:
		is_being_attracted = true
		global_position = global_position.move_toward(player.global_position, magnet_speed * delta)

func reset_state() -> void:
	xp_value = 10
	is_being_attracted = false

func on_spawn() -> void:
	add_to_group("xp_gems")
	visible = true
	monitoring = true
	is_being_attracted = false
	set_process(true)

func on_despawn() -> void:
	remove_from_group("xp_gems")
	visible = false
	monitoring = false
	set_process(false)
