extends CharacterBody2D

@export var speed: float = 50.0

func _ready():
	add_to_group("enemies")  # Enemy joins "enemies" group, not "player"

func _physics_process(_delta: float) -> void:
	# Get reference to player and move toward them
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
