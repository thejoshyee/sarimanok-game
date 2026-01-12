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
    # Connect timer's timeout signal to our callback
    cooldown_timer.timeout.connect(_on_cooldown_done)


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
