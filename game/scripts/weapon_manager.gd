extends Node
class_name WeaponManager


# Signals for passive modifications
signal weapon_attack_started(slot_index: int, weapon: Variant)
signal weapon_attack_completed(slot_index: int, weapon: Variant)

# 6 Weapon Slots - will hold weapon references
var weapon_slots: Array = []

# track cooldowns for each slot (slot_index -> time remaining)
var cooldowns: Dictionary = {}

# reference to player for stat multipliers
var player: CharacterBody2D

func _ready() -> void:
	# initialize 6 weapon slots
	weapon_slots.resize(6)
	for i in range(6):
		weapon_slots[i] = null
		cooldowns[i] = 0.0

func _process(delta: float) -> void:
	# Decrement all active cooldowns
	# Attack Speed Multiplier makes cooldowns count down faster
	var attack_speed = player.stats.attack_speed_multiplier if player else 1.0

	for slot_index in cooldowns.keys():
		if cooldowns[slot_index] > 0:
			cooldowns[slot_index] -= delta * attack_speed
			if cooldowns[slot_index] < 0:
				cooldowns[slot_index] = 0.0

# Get player's damage multiplier for weapon calculations
func get_damage_multiplier() -> float:
	return player.stats.damage_multiplier if player else 1.0

# Get player's attack speed multiplier for weapon calculations
func get_attack_speed_multiplier() -> float:
	return player.stats.attack_speed_multiplier if player else 1.0

# Check if a slot's cooldown is ready (0.0 = ready to fire)
func is_ready(slot_index: int) -> bool:
	if slot_index < 0 or slot_index >= 6:
		return false
	return cooldowns[slot_index] <= 0.0

# Set a weapon's cooldown (called after it attacks)
func set_cooldown(slot_index: int, duration: float) -> void:
	if slot_index >= 0 and slot_index < 6:
		cooldowns[slot_index] = duration
