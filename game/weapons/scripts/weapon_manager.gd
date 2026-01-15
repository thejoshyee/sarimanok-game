extends Node2D
class_name WeaponManager


# Signals for passive modifications
signal weapon_attack_started(slot_index: int, weapon: Variant)
signal weapon_attack_completed(slot_index: int, weapon: Variant)

# Maximum number of weapon slots available to the player
const MAX_WEAPONS: int = 6

# Weapon slots - will hold weapon references
var weapon_slots: Array = []

# track cooldowns for each slot (slot_index -> time remaining)
var cooldowns: Dictionary = {}

# reference to player for stat multipliers
var player: CharacterBody2D

func _ready() -> void:
	# Get player reference from parent (WeaponManager is child of Player)
	player = get_parent()
	
	# initialize weapon slots
	weapon_slots.resize(MAX_WEAPONS)
	for i in range(MAX_WEAPONS):
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

	# auto-attack loop: check each slot for ready weapons
	for slot_index in range(MAX_WEAPONS):
		var weapon = weapon_slots[slot_index]

		# skip empty slots
		if weapon == null:
			continue

		# check if this weapon is ready to attack
		if is_ready(slot_index):
			print("Slot %d ready to attack, cooldown: %.2f" % [slot_index, get_cooldown(slot_index)])

			# check if the weapon has an attack method
			if weapon.has_method("attack"):
				weapon_attack_started.emit(slot_index, weapon)
				weapon.attack()
				weapon_attack_completed.emit(slot_index, weapon)


# Get player's damage multiplier for weapon calculations
func get_damage_multiplier() -> float:
	return player.stats.damage_multiplier if player else 1.0

# Get player's attack speed multiplier for weapon calculations
func get_attack_speed_multiplier() -> float:
	return player.stats.attack_speed_multiplier if player else 1.0

# Check if a slot's cooldown is ready (0.0 = ready to fire)
func is_ready(slot_index: int) -> bool:
	if slot_index < 0 or slot_index >= MAX_WEAPONS:
		return false
	return cooldowns[slot_index] <= 0.0

# Set a weapon's cooldown (called after it attacks)
func set_cooldown(slot_index: int, duration: float) -> void:
	if slot_index >= 0 and slot_index < MAX_WEAPONS:
		cooldowns[slot_index] = duration


# equip a weapon to a specific slot
func equip(slot_index: int, weapon: BaseWeapon) -> void:
	if slot_index >= 0 and slot_index < MAX_WEAPONS:
		weapon_slots[slot_index] = weapon
		cooldowns[slot_index] = 0.0 # Reset cooldown when equipping a new weapon

		# Initialize weapon references
		weapon.weapon_manager = self
		weapon.player = player
		weapon.slot_index = slot_index
		weapon.on_equip() # call weapon's on_equip() method
		
		# add weapon to scene tree
		add_child(weapon)

# Get the current cooldown remaining for a specific slot
func get_cooldown(slot_index: int) -> float:
	if slot_index >= 0 and slot_index < MAX_WEAPONS:
		return cooldowns[slot_index]
	return 0.0
