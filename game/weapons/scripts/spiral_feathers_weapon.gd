class_name SpiralFeathersWeapon
extends Weapon

# === FEATHER SCENE ===
# The OrbitalFeather scene to instantiate for each orbiting feather
@export var feather_scene: PackedScene

# === ORBIT CONFIG ===
# These start with defaults, but get overridden by WeaponData upgrades
var orbit_speed: float = 1.0      # Radians per second
var orbit_radius: float = 32.0    # Distance from player center
var feather_count: int = 4        # How many feathers orbit at once
var feathers: Array = []          # Tracks active OrbitalFeather instances
