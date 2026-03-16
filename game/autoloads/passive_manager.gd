extends Node

# Tracks passive levels during a run
# WHY: Central place for all passive state — weapons/player query modifiers from here
# Passives reset each run (like weapons), persistent upgrades are in GameState

signal passive_upgraded(passive_id: String, new_level: int)

# All available passives (loaded from .tres files in task 30.3)
var passives: Array[PassiveData] = []

# Per-run levels — maps passive id -> current level
# WHY: Separate from PassiveData so the Resource stays clean/reusable
var passive_levels: Dictionary = {}


func _ready() -> void:
	reset()


# Reset all passive levels to 0 — call at start of each run
func reset() -> void:
	passive_levels.clear()
	for passive in passives:
		passive_levels[passive.id] = 0


# Upgrade a passive by 1 level, clamped to max_level
# Returns true if upgrade succeeded, false if already maxed
func upgrade_passive(passive_id: String) -> bool:
	var passive = get_passive(passive_id)
	if passive == null:
		push_warning("PassiveManager: unknown passive '%s'" % passive_id)
		return false
	
	var current = passive_levels.get(passive_id, 0)
	if current >= passive.max_level:
		return false
	
	passive_levels[passive_id] = current + 1
	passive_upgraded.emit(passive_id, current + 1)
	return true


# Get current level of a passive (0 = not acquired)
func get_level(passive_id: String) -> int:
	return passive_levels.get(passive_id, 0)


# Get the PassiveData resource by id, or null if not found
func get_passive(passive_id: String) -> PassiveData:
	for passive in passives:
		if passive.id == passive_id:
			return passive
	return null


# Get the computed bonus for a passive at its current level
# Uses PassiveData.get_bonus() which handles the math
func get_bonus(passive_id: String) -> float:
	var passive = get_passive(passive_id)
	if passive == null:
		return 0.0
	return passive.get_bonus(get_level(passive_id))


# Get the modifier (1.0 + bonus) for multiplicative passives like damage/speed
# WHY: Weapons multiply by this directly: damage *= passive_manager.get_modifier("iron_beak")
func get_modifier(passive_id: String) -> float:
	return 1.0 + get_bonus(passive_id)
