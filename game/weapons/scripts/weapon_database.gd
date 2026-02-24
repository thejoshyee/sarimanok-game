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
