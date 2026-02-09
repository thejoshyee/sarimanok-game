class_name FeatherShotWeapon
extends Weapon


# === PROJECTILE PROPERTIES ===
# Set by _on_stats_changed() from upgrade data in feather_shot.tres
var projectile_count: int = 1    # How many feathers per shot
var pierce_count: int = 1        # How many enemies each feather passes through
var fan_angle: float = 15.0      # Degrees of spread when firing multiple feathers


# === STAT UPDATES ===
# Called by base Weapon when level changes
# Reads projectile stats from upgrade data so balance lives in feather_shot.tres
func _on_stats_changed(upgrade: Dictionary) -> void:
	projectile_count = upgrade.get("projectile_count", projectile_count)
	pierce_count = upgrade.get("pierce_count", pierce_count)


# === FIRING ===
# Called by base Weapon.try_fire() when cooldown is ready
func _do_fire() -> bool:
	# Find all enemies in the scene via group
	# Enemies are added to "enemies" group, so we can query them easily
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.is_empty():
		return false
	
	# Find the closest enemy
	var nearest: Node2D = null
	var nearest_dist: float = INF
	for enemy in enemies:
		var dist = global_position.distance_squared_to(enemy.global_position)
		if dist < nearest_dist:
			nearest_dist = dist
			nearest = enemy
	
	# Direction from weapon (at player) toward nearest enemy
	var base_direction = (nearest.global_position - global_position).normalized()
	
	# Spawn projectiles — fan them out if firing more than one
	for i in projectile_count:
		var angle_offset: float = 0.0
		if projectile_count > 1:
			# Spread evenly across fan_angle
			# Example: 3 projectiles, 15° fan → offsets: -7.5°, 0°, +7.5°
			var fraction = float(i) / float(projectile_count - 1)
			angle_offset = deg_to_rad(fan_angle) * (fraction - 0.5)
		
		var dir = base_direction.rotated(angle_offset)
		
		# Spawn from pool and configure
		var projectile = PoolManager.spawn("projectile_base", global_position)
		if projectile:
			projectile.reset(global_position, dir, damage, pierce_count, weapon_data)
	
	return true
