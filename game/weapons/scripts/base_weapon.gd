extends Node
class_name BaseWeapon

# Ref to weapon manager (set when equipped)
var weapon_manager: WeaponManager

# Ref to the player (for accessing stats)]
var player: CharacterBody2D

# Slot index this weapon is equipped in (0-5)
var slot_index: int = -1

# === ABSTRACT METHODS - Must be overridden by subclasses (Child weapons) ===

func attack() -> void:
	assert(false, "attack() method must be overridden by child weapon class")

func get_base_cooldown() -> float:
	assert(false, "get_base_cooldown() method must be overridden by child weapon class")
	return 0.0

func get_base_damage() -> float:
	assert(false, "get_base_damage() method must be overridden by child weapon class")
	return 0.0

# === VIRTUAL METHODS - Optional overrides with default behavior ===

# Called when weapon is equipped to a slot
func on_equip() -> void:
	pass # no default behavior

# Called when weapon is unequipped
func on_unequip() -> void:
	pass # no default behavior

# Hook for passive modifiers to adjust weapon behavior
func apply_passive_modifiers(_modifier_name: String, _value: float) -> void:
	pass # no default behavior, weapons can override to respond to passives

# === HELPER METHODS - Concrete implementations weapons can use ===

# Calculate final damage including players damage multiplier
func get_final_damage() -> float:
	if not player:
		return get_base_damage()
	return get_base_damage() * player.stats.damage_multiplier

# calc final cooldown accounting for attack speed
func get_final_cooldown() -> float:
	if not player:
		return get_base_cooldown()
	return get_base_cooldown() / player.stats.attack_speed_multiplier

# helper to reset this weapon's cooldown after attacking
func reset_cooldown() -> void:
	if weapon_manager:
		weapon_manager.set_cooldown(slot_index, get_final_cooldown())

# Find the nearest enemy to the player using spatial queries
func find_nearest_enemy() -> Node2D:
	if not player:
		return null
	
	# get all enemies in the "enemies" group
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.is_empty():
		return null
	
	# find closest enemy
	var nearest_enemy = null
	var nearest_distance = INF
	
	for enemy in enemies:
		var distance = player.global_position.distance_to(enemy.global_position)
		if distance < nearest_distance:
			nearest_distance = distance
			nearest_enemy = enemy
	return nearest_enemy

# spawn a projectile from the pool toward the target
func spawn_projectile(target_pos: Vector2) -> void:
	if not player:
		return
	
	# get projectile from pool
	var projectile = PoolManager.spawn("projectile_base", player.global_position)
	if not projectile:
		push_warning("Failed to spawn projectile")
		return

	print("Spawned projectile: ", projectile, " at ", player.global_position)
	
	# Calc direction to target
	var direction = (target_pos - player.global_position).normalized()

	# initialize the projectile
	projectile.reset(player.global_position, direction, get_final_damage())
