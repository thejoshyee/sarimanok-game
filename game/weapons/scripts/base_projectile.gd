extends Area2D
class_name Projectile

var damage: float = 0.0
var speed: float = 300.0
var direction: Vector2 = Vector2.ZERO
var lifetime: float = 5.0  # despawn after 5 seconds
var time_alive: float = 0.0

# === Pierce & Debuff Support ===
# Feather Shot needs pierce (pass through multiple enemies)
# Ice Shard needs debuff forwarding (apply slow on hit)
var pierce_remaining: int = 1       # 1 = dies on first hit, 2 = passes through 1 enemy, etc.
var weapon_data: WeaponData = null   # Reference to weapon's data for debuff info

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
	# Only damage things that can take damage
	if not body.has_method("take_damage"):
		return
	
	# Deal damage
	body.take_damage(damage)
	
	# Apply debuff if weapon_data has one (e.g., Ice Shard's slow)
	if weapon_data and weapon_data.debuff_type != "" and body.has_method("apply_debuff"):
		body.apply_debuff(weapon_data.debuff_type, weapon_data.debuff_strength, weapon_data.debuff_duration)
	
	# Pierce logic: decrement hits remaining, despawn when exhausted
	# pierce_remaining = 3 means "pass through 2 enemies, die on 3rd"
	pierce_remaining -= 1
	if pierce_remaining <= 0:
		despawn()


# Reset projectile state when spawned from pool
# Pooled projectiles get reused — must clear stale data from last use
func reset(start_pos: Vector2, target_direction: Vector2, projectile_damage: float, pierce: int = 1, data: WeaponData = null) -> void:
	global_position = start_pos
	direction = target_direction.normalized()
	damage = projectile_damage
	time_alive = 0.0
	pierce_remaining = pierce
	weapon_data = data
	# Apply weapon's speed modifier (e.g., Ice Shard fires slower at 0.67x)
	if weapon_data:
		speed = 300.0 * weapon_data.speed_modifier
	else:
		speed = 300.0
	# Tint projectile based on weapon (e.g., blue for Ice Shard)
	modulate = weapon_data.projectile_color if weapon_data else Color.WHITE

	

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
