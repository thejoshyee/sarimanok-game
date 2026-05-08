# Generates level-up choices mixing weapons (and later passives)

extends Node

# Set to true to only show filler options
const DEBUG_FILLERS_ONLY: bool = false

# Filler options for when there are no more weapons or passives to upgrade
const FILLER_OPTIONS: Array[Dictionary] = [
	{ "type": "filler_heal", "value": 20, "display_name": "Quick Heal", "icon_color": Color.MEDIUM_SEA_GREEN },
	{ "type": "filler_gold", "value": 50, "display_name": "Gold Bonus", "icon_color": Color.GOLD },
	{ "type": "filler_stat_damage", "value": 5, "display_name": "Sharper Beak", "icon_color": Color.TOMATO },
	{ "type": "filler_stat_speed", "value": 5, "display_name": "Quick Feet", "icon_color": Color.CORNFLOWER_BLUE },
]

## Set by main scene — can't use @onready since autoloads load before scene tree
var weapon_manager: WeaponManager = null

# Per-run filler stat accumulators — wiped each run via reset_run()
var filler_damage_bonus: float = 0.0
var filler_speed_bonus: float = 0.0

func reset_run() -> void:
	filler_damage_bonus = 0.0
	filler_speed_bonus = 0.0

# Build pool of choices: upgrades + new weapons (if slots available)
# Returns Array of Dictionaries: { "type": "new_weapon"/"upgrade_weapon", "data": WeaponData }
func get_choices(count: int = 3) -> Array:
	var pool: Array = []

	# If DEBUG_FILLERS_ONLY is true, return only filler options
	if DEBUG_FILLERS_ONLY:
		return FILLER_OPTIONS.duplicate()

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

	# Shuffle weapon/passive pool and take what's available
	pool.shuffle()
	var choices: Array = pool.slice(0, mini(count, pool.size()))

	# Pad with random fillers (no duplicates) until we have exactly `count`
	var fillers: Array = FILLER_OPTIONS.duplicate()
	fillers.shuffle()
	while choices.size() < count and fillers.size() > 0:
		choices.append(fillers.pop_front())

	print("LevelUpManager.get_choices: returning %d choices" % choices.size())

	return choices
	
func apply_filler(choice: Dictionary) -> void:
	match choice.type:
		"filler_heal":
			var player = get_tree().get_first_node_in_group("player")
			if player and player.has_method("heal"):
				player.heal(choice.value)
		"filler_gold":
			ProgressionManager.add_gold(choice.value)
		"filler_stat_damage":
			filler_damage_bonus += choice.value / 100.0
			_refresh_weapon_damage()
		"filler_stat_speed":
			filler_speed_bonus += choice.value / 100.0

func _refresh_weapon_damage() -> void:
	if weapon_manager == null:
		return
	for weapon in weapon_manager.weapon_slots:
		if weapon != null:
			weapon._apply_level_stats()
