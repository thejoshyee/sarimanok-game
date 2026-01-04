extends CharacterBody2D

## Base Duwende enemy with pooling support
## Green/Red Variants use this script with different exported stats

# Movement speed in pixels per second
@export var base_speed: float = 80.0
var speed: float = base_speed

# Damage and HP Stats for scaling
@export var base_damage: int = 5
@export var base_max_hp: int = 10
var damage: int = base_damage
var current_hp: int = base_max_hp

# Grid tracking for spatial partitioning
var _current_cell_id: int = -1

# reference to the player node
@onready var player: Node2D = get_tree().get_first_node_in_group("player")
@onready var damage_area: Area2D = $DamageArea

func _ready() -> void:
	damage_area.body_entered.connect(_on_damage_area_body_entered)


# Call this after spawning to apply time-based difficulty scaling
func initialize_stats(elapsed_minutes: float) -> void:
	current_hp = SpawnManager.get_scaled_hp(base_max_hp, elapsed_minutes)
	damage = SpawnManager.get_scaled_damage(base_damage, elapsed_minutes)
	# print("Enemy spawned with HP: ", current_hp, " Damage: ", damage)


# Called when this enemy takes damage from weapons / projectiles
func take_damage(amount: int) -> void:
	current_hp -= amount
	if current_hp <= 0:
		die()


# Handle enemy death - cleanup and rewards
func die() -> void:
	# TODO: Spawn XP pickup here
	PoolManager.despawn(self)


# === POOLING LIFECYCLE ===

func on_spawn() -> void:
	# Called when pulled from pool - make enemy active
	visible = true
	set_physics_process(true)
	add_to_group("enemies") # Only in group when active
	# register with grid system for spatial queries
	GridManager.register_enemy(self)
	_current_cell_id = GridManager.get_cell_id(global_position)


func on_despawn() -> void:
	# Called when returned to pool - make enemy inactive
	visible = false
	set_physics_process(false)
	remove_from_group("enemies") # remove when inactive
	# unregister from grid system
	if _current_cell_id != -1:
		GridManager.unregister_enemy(self, _current_cell_id)
		_current_cell_id = -1


func reset_state() -> void:
	# Reset velocity when recycled from pool
	velocity = Vector2.ZERO


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
		PoolManager.despawn(self)
