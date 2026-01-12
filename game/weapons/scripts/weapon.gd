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
