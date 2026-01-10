extends Area2D
class_name BaseProjectile

var damage: float = 0.0
var speed: float = 300.0
var direction: Vector2 = Vector2.ZERO
var lifetime: float = 5.0  # despawn after 5 seconds
var time_alive: float = 0.0

func _ready() -> void:
	# connect to body_entered to detect hitting enemies
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	# move in direction
	position += direction * speed * delta

	# track lifetime and despawn if too old
	time_alive += delta
	if time_alive >= lifetime:
		despawn()

func _on_body_entered(body: Node2D) -> void:
	# check if we hit an enemy
	if body.is_in_group("enemies") and body.has_method("take_damage"):
		body.take_damage(damage)
		despawn()

# reset projectile state when spawned from pool
func reset(start_pos: Vector2, target_direction: Vector2, projectile_damage: float) -> void:
	global_position = start_pos
	direction = target_direction.normalized()
	damage = projectile_damage
	time_alive = 0.0

# Called when spawned from pool
func on_spawn() -> void:
	visible = true
	set_physics_process(true)
	set_deferred("monitoring", true)  # Enable collision detection


# Called when returned to pool
func on_despawn() -> void:
	visible = false
	set_physics_process(false)
	set_deferred("monitoring", false)  # Disable collision detection

# return projectile to pool instead of freeing it
func despawn() -> void:
	if PoolManager:
		PoolManager.despawn(self)
