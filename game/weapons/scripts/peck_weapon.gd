class_name PeckWeapon
extends Weapon


# === PROJECTILE PROPERTIES ===
# These are set by _on_stats_changed() from upgrade data
# so balance tuning happens in peck.tres
var projectile_count: int = 1        # How many beaks to fire per shot
var spread_angle: float = 0.0        # Total spread in degrees (0 = single straight shot)
var projectile_range: float = 100.0  # Max travel distance per beak (matches BeakProjectile default)


# === STAT UPDATES ===
# Called by base Weapon when level changes
func _on_stats_changed(upgrade: Dictionary) -> void:
	# Read projectile stats from upgrade data, fallback to current values
	# Each level can override these in peck.tres without touching code
	projectile_count = upgrade.get("projectile_count", projectile_count)
	spread_angle = upgrade.get("spread_angle", spread_angle)
	projectile_range = upgrade.get("projectile_range", projectile_range)


# === FIRING ===
# Called by base Weapon.try_fire() when cooldown is ready
func _do_fire() -> bool:
	# Get player reference through WeaponManager
	var weapon_manager = get_parent()
	var player = weapon_manager.player
	
	# Guard: Can't fire without a valid player
	if player == null:
		return false
	
	# Determine firing direction based on player's movement
	# Peck fires where you're walking. If steationary, use last rotation
	var base_direction: Vector2
	if player.velocity.length() > 0:
		base_direction = player.velocity.normalized()
	else:
		# use weapons current rotation as fallback (last facing direction)
		base_direction = Vector2.RIGHT.rotated(rotation)

	# update rotation to match firing direction (for next stationary fallback)
	rotation = base_direction.angle()

	# calculate angle for each projectile in the spread
	# even spread across the arc. 1 projectile = straight, 2+ = fan pattern
	for i in projectile_count:
		var angle_offset: float = 0.0
		if projectile_count > 1:
			# Distribute evently across the spread_angle
			# example: 3 projectiles, 30 degree spread -> offsets: -15 degrees, 0 degrees, +15 degrees 
			var fraction: float = float(i) / float(projectile_count - 1) # 0.0 to 1
			angle_offset = deg_to_rad(spread_angle) * (fraction - 0.5) 

		# Rotate base direction by this projectiles offset
		var dir: Vector2 = base_direction.rotated(angle_offset)

		# spawn from pool and launch
		var projectile = PoolManager.spawn("projectile_beak", global_position)
		if projectile:
			projectile.max_distance = projectile_range
			projectile.launch(dir, damage)

	# return true to indicate we fired successfully
	return true
