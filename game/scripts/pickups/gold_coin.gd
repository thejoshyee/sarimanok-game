extends Area2D

# How much gold this coin gives when collected
@export var gold_value: int = 1

# Magnetic drift settings
var pickup_range: float = 64.0
var magnet_speed: float = 100.0
var is_being_attracted: bool = false

func _process(delta: float) -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.is_empty():
		return
	var player = players[0]
	
	var effective_range = pickup_range * PassiveManager.get_modifier("magnetic_aura")
	var distance = global_position.distance_to(player.global_position)
	
	if distance < effective_range:
		is_being_attracted = true
		global_position = global_position.move_toward(player.global_position, magnet_speed * delta)

func reset_state() -> void:
	gold_value = 1
	is_being_attracted = false

func on_spawn() -> void:
	add_to_group("gold_coins")
	visible = true
	monitoring = true
	is_being_attracted = false
	set_process(true)

func on_despawn() -> void:
	remove_from_group("gold_coins")
	visible = false
	monitoring = false
	set_process(false)
