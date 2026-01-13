class_name Weapon
extends Node2D

# === DATA SOURCE ===
# The WeaponData resource that defines this weapon's stats
# Assigned in the Inspector by dragging a .tres file
@export var weapon_data: WeaponData


# === RUNTIME STATE ===
# These track the weapon's current state during gameplay
var level: int = 1  # Current upgrade level (1-5)
var current_cooldown: float = 0.0  # Time remaining until can fire again
var damage: int = 0  # Computed damage based on level + upgrades
var can_fire: bool = true  # Can this weapon fire right now?


# === NODE REFERENCES ===
@onready var cooldown_timer: Timer = $cooldown_timer


func _ready() -> void:
	# Validate: Weapon must have data assigned in Inspector
	assert(weapon_data != null, "Weapon requires weapon_data resource assigned!")

	# Connect timer's timeout signal to our callback
	# Guard: Only connect if not already connected
	# WHY: Prevents duplicate callbacks if _ready() somehow runs twice
	if not cooldown_timer.timeout.is_connected(_on_cooldown_done):
		cooldown_timer.timeout.connect(_on_cooldown_done)
	
	# Compute initial stats based on current level
	_apply_level_stats()


# === LEVEL & STATS ===

# Sets weapon level at runtime, clamping to valid range
# WHY: Ensures stats are recomputed whenever level changes
func set_level(new_level: int) -> void:
	# Clamp to valid range (weapons go from level 1 to 5)
	var clamped := clampi(new_level, 1, 5)
	
	# Early return if no actual change (idempotent)
	# WHY: Prevents unnecessary stat recalculation and side effects
	if clamped == level:
		return
	
	# Update level and recompute all stats
	level = clamped
	_apply_level_stats()


# Computes weapon stats based on current level and WeaponData
func _apply_level_stats() -> void:
	# Get upgrade data for current level (empty dict if no upgrade exists)
	var upgrade := weapon_data.get_upgrade(level)
	
	# Compute damage: base value + any upgrade bonus
	# upgrade.get() returns 0 if key doesn't exist
	damage = int(weapon_data.base_damage + upgrade.get("damage", 0))
	
	# Let subclasses react to stat changes (e.g., update radius, projectile count)
	_on_stats_changed(upgrade)


# Virtual: Subclasses override to react when stats change
# Example: AOE weapon updates its collision radius, projectile weapon updates count
func _on_stats_changed(_upgrade: Dictionary) -> void:
	# Base class does nothing - subclasses implement as needed
	pass


# === FIRING SYSTEM ===
# Called by WeaponManager to attempt firing this weapon
func try_fire() -> void:
	# Guard: Don't fire if we're still on cooldown
	if not can_fire:
		return
	
	# Attempt to fire - _do_fire() returns true if a shot happened
	if _do_fire():
		_start_cooldown()


# Virtual: Subclasses override to perform actual attack
# Returns true if a shot was fired, false if firing was blocked
func _do_fire() -> bool:
	# Base class does nothing - subclasses implement actual behavior
	return false


# Begins the cooldown period after firing
func _start_cooldown() -> void:
	can_fire = false
	
	# Get cooldown duration from weapon data
	current_cooldown = weapon_data.cooldown
	
	# Edge case: if cooldown is 0 or negative, weapon can fire instantly
	if current_cooldown <= 0.0:
		can_fire = true
		return
	
	# Configure and start the timer
	cooldown_timer.wait_time = current_cooldown
	cooldown_timer.start()


# Called when cooldown_timer finishes - weapon can fire again
func _on_cooldown_done() -> void:
	can_fire = true
