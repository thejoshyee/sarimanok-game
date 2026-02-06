extends Node2D
class_name WeaponManager


# Maximum number of weapon slots available to the player
const MAX_WEAPONS: int = 6

# Weapon slots - will hold weapon references
var weapon_slots: Array = []

# reference to player for stat multipliers
var player: CharacterBody2D

# Maps weapon ID (String) → weapon scene (PackedScene)
@export var weapon_scenes: Dictionary = {}


func _ready() -> void:
	# TODO: Replace with specific weapon scenes when created
	# Using generic weapon_base.tscn as placeholder for all weapons
	weapon_scenes["peck"] = preload("res://weapons/scenes/peck.tscn")
	weapon_scenes["wing_slap"] = preload("res://weapons/scenes/wing_slap_weapon.tscn")
	weapon_scenes["feather_shot"] = preload("res://weapons/scenes/weapon_base.tscn")
	weapon_scenes["spiral_feathers"] = preload("res://weapons/scenes/weapon_base.tscn")
	weapon_scenes["ice_shard"] = preload("res://weapons/scenes/weapon_base.tscn")
	weapon_scenes["flame_wing"] = preload("res://weapons/scenes/flame_wing_weapon.tscn")


	# Get player reference from parent (WeaponManager is child of Player)
	player = get_parent()

	# Initialize weapon slots
	weapon_slots.resize(MAX_WEAPONS)
	for i in range(MAX_WEAPONS):
		weapon_slots[i] = null


func _process(_delta: float) -> void:
	# Auto-fire loop: position weapons and trigger firing
	for slot_index in range(MAX_WEAPONS):
		var weapon = weapon_slots[slot_index]

		# Skip empty slots
		if weapon == null:
			continue

		# Position weapon at player (weapons fire from player's location)
		weapon.global_position = player.global_position

		# Weapon class uses can_fire + try_fire() pattern
		if weapon.can_fire:
			weapon.try_fire()


# Get player's damage multiplier for weapon calculations
func get_damage_multiplier() -> float:
	return player.stats.damage_multiplier if player else 1.0


# Get player's attack speed multiplier for weapon calculations
func get_attack_speed_multiplier() -> float:
	return player.stats.attack_speed_multiplier if player else 1.0


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
	# Check if we already have this weapon
	if get_weapon_by_id(data.id) != null:
		push_warning("WeaponManager: Already have weapon '%s'" % data.id)
		return false

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


# === QUERYING APIs ===

# Finds a weapon by its unique id (e.g., "peck", "wing_slap")
# Returns the Weapon instance if found, null if not equipped
func get_weapon_by_id(id: String) -> Weapon:
	for weapon in weapon_slots:
		# Skip empty slots
		if weapon == null:
			continue
		# Check if this weapon's data matches the requested id
		if weapon.weapon_data.id == id:
			return weapon
	return null


# Upgrades a weapon by its id, incrementing its level by 1
# Returns true if upgrade succeeded, false if weapon not found
func upgrade_weapon(id: String) -> bool:
	var weapon := get_weapon_by_id(id)
	if weapon == null:
		push_warning("WeaponManager: Cannot upgrade '%s' - weapon not found" % id)
		return false
	
	# Increment level (set_level handles clamping to max of 5)
	weapon.set_level(weapon.level + 1)
	return true


# Returns cooldown remaining for weapon in slot, or 0 if empty/ready
func get_cooldown(slot_index: int) -> float:
	if slot_index < 0 or slot_index >= MAX_WEAPONS:
		return 0.0
	
	var weapon = weapon_slots[slot_index]
	if weapon == null:
		return 0.0
	
	# Return time left on cooldown timer, or 0 if ready to fire
	if weapon.can_fire:
		return 0.0
	return weapon.cooldown_timer.time_left
