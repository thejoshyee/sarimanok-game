extends CharacterBody2D


var speed = 150.0
var circle_radius = 100.0
var angle = 0.0

func _physics_process(delta) -> void:
	# circular movement pattern for testing
	angle += delta * 2.0 # Speed of Circular Motion

	var center = Vector2(320, 180) # Viewport Center
	var target_pos = center + Vector2(cos(angle), sin(angle)) * circle_radius

	var direction = (target_pos - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
