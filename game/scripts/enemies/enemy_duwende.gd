extends CharacterBody2D

## Base Duwende enemy with pooling support
## Green/Red Variants use this script with different exported stats

# Movement speed in pixels per second
@export var base_speed: float = 80.0
var speed: float = base_speed

# Damage and HP Stats for scaling
@export var base_damage: int = 5
@export var base_max_hp: int = 10

# Drop amounts on death (Green defaults, Red overrides in scene)
@export var xp_drop_count: int = 1
@export var gold_drop_count: int = 1

# Preload death effect scene for instant spawning
const DeathParticles = preload("res://scenes/effects/death_particles.tscn")

var damage: int = base_damage
var current_hp: int = base_max_hp

# Grid tracking for spatial partitioning
var _current_cell_id: int = -1

# reference to the player node
@onready var player: Node2D = get_tree().get_first_node_in_group("player")
@onready var damage_area: Area2D = $DamageArea

func _ready() -> void:
	damage_area.body_entered.connect(_on_damage_area_body_entered)


# Forward debuff application to the DebuffHandler child node
func apply_debuff(debuff_type: String, strength: float, duration: float) -> void:
	$DebuffHandler.apply_debuff(debuff_type, strength, duration)


# Expose slow factor so movement code can use it
func get_total_slow_factor() -> float:
	return $DebuffHandler.get_total_slow_factor()



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


# Handle enemy death - spawn drops and return to pool
func die() -> void:
	var drop_pos = global_position

	# Spawn death particle effect at enemy position
	var particles = DeathParticles.instantiate()
	particles.global_position = drop_pos
	get_tree().current_scene.add_child(particles)
	particles.emitting = true  # Start the burst
	
	# Pick a random base direction for XP
	var xp_base_angle = randf() * TAU
	# Gold spawns on OPPOSITE side (180° offset)
	var gold_base_angle = xp_base_angle + PI
	
	# Spawn XP gems clustered in one direction
	for i in xp_drop_count:
		var angle = xp_base_angle + randf_range(-0.5, 0.5)  # Slight spread within sector
		var distance = randf_range(40, 60)  # was 20-40, now 40-60
		var offset = Vector2(cos(angle), sin(angle)) * distance
		PoolManager.spawn("pickup_xp_gem", drop_pos + offset)
	
	# Spawn gold coins clustered in opposite direction
	for i in gold_drop_count:
		var angle = gold_base_angle + randf_range(-0.5, 0.5)
		var distance = randf_range(40, 60)  # was 20-40, now 40-60
		var offset = Vector2(cos(angle), sin(angle)) * distance
		PoolManager.spawn("pickup_gold_coin", drop_pos + offset)
	
	# Return enemy to pool
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
	# Reset HP to base value (initialize_stats will scale it after)
	current_hp = base_max_hp
	# Reset debuffs
	$DebuffHandler.active_debuffs.clear()


func _physics_process(_delta: float) -> void:
	# safety check: stop if player doesn't exist
	if player == null:
		return

	# calculate direction vector from enemy to player
	var direction: Vector2 = (player.global_position - global_position).normalized()

	# Set velocity and move using CharacterBody2D's built-in method
	velocity = direction * speed * get_total_slow_factor()
	move_and_slide()


func _on_damage_area_body_entered(body: Node2D) -> void:
	# check if we hit the player
	if body.is_in_group("player") and body.has_method("take_damage"):
		# deal damage to the palyer using our damage stat
		body.take_damage(damage)
		# remove this enemy from the scene
		PoolManager.despawn(self)
