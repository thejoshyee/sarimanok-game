extends Area2D

# How much gold this coin gives when collected
@export var gold_value: int = 1

func reset_state() -> void:
	# Reset any state when reused from pool
	gold_value = 1

func on_spawn() -> void:
	add_to_group("gold_coins")
	visible = true
	monitoring = true

func on_despawn() -> void:
	remove_from_group("gold_coins")
	visible = false
	monitoring = false
