extends CharacterBody2D


var speed = 80.0
@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta: float) -> void:
	if player:
		var direction = (player.position - position).normalized()
		velocity = direction * speed
		move_and_slide()
