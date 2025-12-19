extends Area2D

# How much XP this gem gives when collected
@export var xp_value: int = 10

func reset_state() -> void:
	# Reset any sttate when reused from pool
	xp_value = 10

func on_spawn() -> void:
	# called when this gem is taken from the pool
	visible = true
	monitoring = true # enable area2d collision detection

func on_despawn() -> void:
	# cdalled when returned to the pool
	visible = false
	monitoring = false # disable area2d collision detection to save performance
	
