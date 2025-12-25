extends Area2D


# Movement speed in pixels per second
@export var base_speed: float = 80.0
var speed: float = base_speed

# reference to the player node
@onready var player: Node2D = get_tree().get_first_node_in_group("player")

func _physics_process(_delta: float) -> void:
	# safety check: stop if player doesn't exist
	if player == null:
		return

	# calculate direction vector from enemy to player
	var direction: Vector2 = (player.global_position - global_position).normalized()

	# move the enemy toward the player
	global_position += direction * speed * _delta
	# print("Direction: ", direction, " | Position: ", global_position)
