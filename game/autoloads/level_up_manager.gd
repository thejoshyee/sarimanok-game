extends Node

# Generates level-up choices mixing weapons (and later passives)
# WHY: Central place so level_up_panel doesn't need to know
# about WeaponDatabase, PassiveManager, or pool-building rules

## Set by main scene — can't use @onready since autoloads load before scene tree
var weapon_manager: WeaponManager = null


# Build pool of choices: upgrades + new weapons (if slots available)
# Returns Array of Dictionaries: { "type": "new_weapon"/"upgrade_weapon", "data": WeaponData }
func get_choices(count: int = 3) -> Array:
	var pool: Array = []
	
	# --- Weapon upgrades: owned weapons below max level ---
	var upgradeable: Array[WeaponData] = WeaponDatabase.get_upgradeable_weapons(weapon_manager)
	for data in upgradeable:
		pool.append({ "type": "upgrade_weapon", "data": data })
	
	# --- New weapons: only if player has open slots ---
	var has_open_slots: bool = weapon_manager._get_weapon_count() < WeaponManager.MAX_WEAPONS
	if has_open_slots:
		var unowned: Array[WeaponData] = WeaponDatabase.get_unowned_weapons(weapon_manager)
		for data in unowned:
			pool.append({ "type": "new_weapon", "data": data })

	# --- Passive upgrades: any passive below max level ---
	for passive in PassiveManager.passives:
		var current_level = PassiveManager.get_level(passive.id)
		if current_level < passive.max_level:
			pool.append({ "type": "upgrade_passive", "data": passive })

	# --- Edge case: fewer choices than requested ---
	if pool.size() < count:
		push_warning("LevelUpManager: only %d choices available (requested %d)" % [pool.size(), count])

	# Shuffle and return up to 'count' choices
	pool.shuffle()
	return pool.slice(0, mini(count, pool.size()))


# When all upgrades are maxed, grant a consolation HP heal instead of showing panel
const HEAL_PERCENT: float = 0.10  # 10% of max HP

func grant_consolation_heal() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player and player.has_method("heal"):
		var heal_amount = int(player.get_effective_max_hp() * HEAL_PERCENT)
		player.heal(heal_amount)
		print("LevelUpManager: Pool empty — healed player for ", heal_amount, " HP")
	else:
		push_warning("LevelUpManager: No player or heal method found for consolation heal")
