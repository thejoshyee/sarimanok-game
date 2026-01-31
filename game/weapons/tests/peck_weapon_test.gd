extends Node2D


## Test scene for Peck weapon projectile behavior
## Controls: Arrow keys to move, 1-5 to change weapon level, P for pool stats


# === POOL CONFIG ===
# Must register projectile pool before weapon can fire
var beak_pool_config: PoolConfig = preload("res://resources/beak_projectile_pool.tres")


# === REFERENCES ===
@onready var player: CharacterBody2D = $SarimanokPlayer
@onready var weapon_manager: WeaponManager = $SarimanokPlayer/WeaponManager

# Peck weapon reference - we'll grab this in _ready
var peck_weapon: Weapon = null


func _ready() -> void:
	# Register the beak pool
	PoolManager.register_pool(beak_pool_config)

	# Give pools a frame to initialize before we query them
	await get_tree().process_frame
	
	# Get reference to the Peck weapon from WeaponManager
	peck_weapon = weapon_manager.get_weapon_by_id("peck")
	
	if peck_weapon:
		print("=== Peck Weapon Test Ready ===")
		print("Controls: WASD/Arrows to move, 1-5 to set level, P for pool stats")
		_print_current_stats()
	else:
		push_error("Peck weapon not found! Check that player has Peck equipped.")


func _input(event: InputEvent) -> void:
	# Number keys 1-5 change weapon level for testing spread patterns
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1: _set_weapon_level(1)
			KEY_2: _set_weapon_level(2)
			KEY_3: _set_weapon_level(3)
			KEY_4: _set_weapon_level(4)
			KEY_5: _set_weapon_level(5)
			KEY_P: _print_pool_stats()


func _set_weapon_level(new_level: int) -> void:
	if peck_weapon == null:
		return
	
	# Directly set the level (bypassing normal upgrade flow for testing)
	peck_weapon.level = new_level
	peck_weapon._apply_level_stats()  # Refresh stats from weapon_data
	
	print("\n--- Level changed to %d ---" % new_level)
	_print_current_stats()


func _print_current_stats() -> void:
	if peck_weapon == null:
		return
	
	# Cast to PeckWeapon to access projectile-specific properties
	var peck := peck_weapon as PeckWeapon
		# Get cooldown from upgrade data (levels 4-5 override base cooldown)
	var upgrade := peck.weapon_data.get_upgrade(peck.level)
	var cooldown: float = upgrade.get("cooldown", peck.weapon_data.cooldown)
	
	print("Damage: %d | Cooldown: %.2fs | Projectiles: %d | Spread: %.0f°" % [
		peck.damage,
		cooldown,
		peck.projectile_count,
		peck.spread_angle
	])



func _print_pool_stats() -> void:
	print("\n=== Pool Stats ===")
	
	# Get stats for the beak projectile pool
	var stats: Dictionary = PoolManager.get_pool_stats("projectile_beak")
	
	if stats.is_empty():
		print("Pool 'projectile_beak' not found - is it registered?")
		return
	
	# Stats show: how many active (in use) vs available (in pool ready to reuse)
	print("projectile_beak: Active=%d | Available=%d | Total=%d" % [
		stats.get("active", 0),
		stats.get("available", 0),
		stats.get("total", 0)
	])
