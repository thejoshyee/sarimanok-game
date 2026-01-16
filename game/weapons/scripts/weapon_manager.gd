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

# Maps weapon ID (String) → weapon scene (PackedScene)
# Configure in Inspector: drag .tscn files for each weapon ID
@export var weapon_scenes: Dictionary = {}

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


# === WEAPON INSTANTIATION ===

# Looks up the PackedScene for a WeaponData by its id
# Returns null if weapon ID not found in weapon_scenes dictionary
func _get_weapon_scene_for_data(data: WeaponData) -> PackedScene:
	if data == null:
		push_warning("WeaponManager: Cannot get scene for null WeaponData")
		return null
	
	# Look up scene by weapon's unique ID (e.g., "peck", "wing_slap")
	if weapon_scenes.has(data.id):
		return weapon_scenes[data.id]
	
	push_warning("WeaponManager: No scene registered for weapon id '%s'" % data.id)
	return null


# Adds a weapon to the first available slot
# Returns true if weapon was added, false if at capacity or invalid data
func add_weapon(data: WeaponData) -> bool:
	# Check if we've hit the weapon limit
	var current_count := _get_weapon_count()
	if current_count >= MAX_WEAPONS:
		push_warning("WeaponManager: Cannot add weapon, at max capacity (%d)" % MAX_WEAPONS)
		return false
	
	# Get the scene for this weapon type
	var scene := _get_weapon_scene_for_data(data)
	if scene == null:
		return false  # Warning already printed by helper
	
	# Instantiate the weapon
	var weapon: Weapon = scene.instantiate()
	if weapon == null:
		push_warning("WeaponManager: Failed to instantiate weapon scene")
		return false
	
	# Configure the weapon
	weapon.weapon_data = data
	weapon.set_level(1)  # New weapons always start at level 1
	
	# Find first empty slot and assign
	var slot_index := _find_empty_slot()
	weapon_slots[slot_index] = weapon
	
	# Add to scene tree (makes it process and render)
	add_child(weapon)
	
	return true


# Returns count of non-null weapons in slots
func _get_weapon_count() -> int:
	var count := 0
	for weapon in weapon_slots:
		if weapon != null:
			count += 1
	return count


# Finds first empty slot index, returns -1 if none
func _find_empty_slot() -> int:
	for i in range(MAX_WEAPONS):
		if weapon_slots[i] == null:
			return i
	return -1
