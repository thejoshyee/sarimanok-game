extends Area2D

# How much XP this gem gives when collected
@export var xp_value: int = 10

func reset_state() -> void:
	# Reset any sttate when reused from pool
	xp_value = 10

func on_spawn() -> void:
	add_to_group("xp_gems")
	# called when this gem is taken from the pool
	visible = true
	monitoring = true # enable area2d collision detection

func on_despawn() -> void:
	# called when returned to the pool
	remove_from_group("xp_gems")
	visible = false
	monitoring = false # disable area2d collision detection to save performance
	
