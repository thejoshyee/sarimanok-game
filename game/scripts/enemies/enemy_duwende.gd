extends CharacterBody2D


# Movement speed in pixels per second
@export var base_speed: float = 80.0
var speed: float = base_speed

# Damage and HP Stats for scaling
@export var base_damage: int = 5
@export var base_max_hp: int = 10
var damage: int = base_damage
var hp: int = base_max_hp

# reference to the player node
@onready var player: Node2D = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	add_to_group("enemies") # add to group for player damage detection

func _physics_process(_delta: float) -> void:
	# safety check: stop if player doesn't exist
	if player == null:
		return

	# calculate direction vector from enemy to player
	var direction: Vector2 = (player.global_position - global_position).normalized()

	# Set velocity and move using CharacterBody2D's built-in method
	velocity = direction * speed
	move_and_slide()
	
