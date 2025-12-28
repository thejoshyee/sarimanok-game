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
@onready var damage_area: Area2D = $DamageArea

func _ready() -> void:
	add_to_group("enemies") # add to group for player damage detection
	damage_area.body_entered.connect(_on_damage_area_body_entered)


# Call this after spawning to apply time-based difficulty scaling
func initialize_stats(elapsed_minutes: float) -> void:
	hp = SpawnManager.get_scaled_hp(base_max_hp, elapsed_minutes)
	damage = SpawnManager.get_scaled_damage(base_damage, elapsed_minutes)


func _physics_process(_delta: float) -> void:
	# safety check: stop if player doesn't exist
	if player == null:
		return

	# calculate direction vector from enemy to player
	var direction: Vector2 = (player.global_position - global_position).normalized()

	# Set velocity and move using CharacterBody2D's built-in method
	velocity = direction * speed
	move_and_slide()


func _on_damage_area_body_entered(body: Node2D) -> void:
	# check if we hit the player
	if body.is_in_group("player") and body.has_method("take_damage"):
		# deal damage to the palyer using our damage stat
		body.take_damage(damage)
		# remove this enemy from the scene
		queue_free()
