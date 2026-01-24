class_name BeakProjectile
extends Area2D

# === PROJECTILE STATS ===
# Short range (100px) makes this melee-like, not a long-range projectile
var speed: float = 300.0
var max_distance: float = 100.0
var damage: int = 0

# === RUNTIME STATE ===
# Track these each frame to know when to despawn
var direction: Vector2 = Vector2.ZERO
var distance_traveled: float = 0.0


func _ready() -> void:
	# body_entered fires when we hit an enemy (CharacterBody2D/RigidBody2D)
	# This lets us detect hits and deal damage
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	# Calculate movement this frame
	var movement: Vector2 = direction * speed * delta
	
	# Move the projectile
	position += movement
	
	# Track total distance traveled
	# We despawn at max_distance, not time - gives consistent range
	distance_traveled += movement.length()
	
	if distance_traveled >= max_distance:
		despawn()


func _on_body_entered(body: Node2D) -> void:
	# WHY: Check for take_damage method instead of group
	# More flexible - any damageable object works, not just "enemies" group
	if body.has_method("take_damage"):
		body.take_damage(damage)
		despawn()


func launch(dir: Vector2, dmg: int) -> void:
	# Normalize direction to ensure consistent speed
	# If you pass a non-unit vector, speed would vary
	direction = dir.normalized()
	damage = dmg
	
	# Reset distance so we travel the full max_distance
	distance_traveled = 0.0


# === POOLING LIFECYCLE ===
# WHY: TypedPool calls these in order: reset_state() -> on_spawn() when acquiring
#      and on_despawn() when releasing back to pool

func reset_state() -> void:
	# Clear runtime variables to fresh state
	direction = Vector2.ZERO
	distance_traveled = 0.0
	damage = 0


func on_spawn() -> void:
	# Make projectile visible and active
	visible = true
	set_physics_process(true)
	set_deferred("monitoring", true)  # Enable collision detection


func on_despawn() -> void:
	# Hide and disable - projectile sits dormant in pool
	visible = false
	set_physics_process(false)
	set_deferred("monitoring", false)  # Disable collision detection


func despawn() -> void:
	# Use PoolManager instead of queue_free()
	# This recycles the object instead of destroying it - better performance
	if PoolManager:
		PoolManager.despawn(self)
