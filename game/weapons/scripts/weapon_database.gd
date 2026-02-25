extends Node

# All weapon data resources in the game
# Central registry so level-up choices can query "what weapons exist?"
var _weapons: Array[WeaponData] = []

func _ready() -> void:
	# Load all WeaponData .tres files
	# Adding a new weapon = drop a .tres file, no code changes needed
	_weapons = [
		preload("res://weapons/data/peck.tres"),
		preload("res://weapons/data/wing_slap.tres"),
		preload("res://weapons/data/feather_shot.tres"),
		preload("res://weapons/data/spiral_feathers.tres"),
		preload("res://weapons/data/ice_shard.tres"),
		preload("res://weapons/data/flame_wing.tres"),
	]
 

# Returns all weapon data resources
func get_all_weapons() -> Array[WeaponData]:
	return _weapons


# Find a specific WeaponData by its id (e.g., "peck")
func get_weapon_by_id(id: String) -> WeaponData:
	for weapon in _weapons:
		if weapon.id == id:
			return weapon
	return null


# Returns weapons the player does NOT currently have equipped
# Level-up screen needs to know what NEW weapons to offer
func get_unowned_weapons(weapon_manager: WeaponManager) -> Array[WeaponData]:
	var unowned: Array[WeaponData] = []
	for weapon in _weapons:
		if weapon_manager.get_weapon_by_id(weapon.id) == null:
			unowned.append(weapon)
	return unowned


# Returns weapons the player HAS that can still be upgraded (level < 5)
# Level-up screen needs to know what UPGRADES to offer
func get_upgradeable_weapons(weapon_manager: WeaponManager) -> Array[WeaponData]:
	var upgradeable: Array[WeaponData] = []
	for weapon in _weapons:
		var equipped = weapon_manager.get_weapon_by_id(weapon.id)
		if equipped != null and equipped.level < 5:
			upgradeable.append(weapon)
	return upgradeable


# Generates up to 'count' level-up choices for the player
# Returns Array of Dictionaries: { "type": "new"/"upgrade", "weapon_data": WeaponData }
# UI needs to know if a choice adds a new weapon or upgrades existing
func get_level_up_choices(weapon_manager: WeaponManager, count: int = 3) -> Array:
	var choices: Array = []
	
	# Gather possible options
	var unowned: Array[WeaponData] = get_unowned_weapons(weapon_manager)
	var upgradeable: Array[WeaponData] = get_upgradeable_weapons(weapon_manager)
	
	# Can only offer new weapons if player has room
	var can_add_new: bool = weapon_manager._get_weapon_count() < WeaponManager.MAX_WEAPONS
	
	# Build pool of all valid choices
	var pool: Array = []
	
	if can_add_new:
		for data in unowned:
			pool.append({ "type": "new", "weapon_data": data })
	
	for data in upgradeable:
		pool.append({ "type": "upgrade", "weapon_data": data })
	
	# Shuffle and pick up to 'count' choices
	# TODO (Update 2): Add weighted selection when weapon pool grows beyond 6
	pool.shuffle()
	for i in range(mini(count, pool.size())):
		choices.append(pool[i])
	
	return choices
