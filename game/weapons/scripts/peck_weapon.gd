class_name PeckWeapon
extends Weapon

# === CONSTANTS ===
const PECK_LENGTH: float = 50.0  # How far the peck reaches (pixels)
const DEFAULT_ARC_ANGLE: float = 50.0  # Default arc width in degrees


# === NODE REFERENCES ===
@onready var hit_area: Area2D = $HitArea
@onready var collision_shape: CollisionPolygon2D = $HitArea/CollisionPolygon2D


# === COMPUTED STATS ===
# Cooldown read from upgrade data (set in _on_stats_changed)
var effective_cooldown: float


# === STAT UPDATES ===
# Called by base Weapon when level changes
func _on_stats_changed(upgrade: Dictionary) -> void:
	# Read cooldown from upgrade data, fallback to base cooldown
	effective_cooldown = upgrade.get("cooldown", weapon_data.cooldown)
	
	# Read arc angle from upgrade data, fallback to default
	var arc_angle: float = upgrade.get("arc_angle", DEFAULT_ARC_ANGLE)
	_update_collision_arc(arc_angle)


# Recalculates the collision polygon based on arc angle
func _update_collision_arc(arc_angle_degrees: float) -> void:
	# Convert to radians and get half-angle (we measure from center to edge)
	var half_angle_rad: float = deg_to_rad(arc_angle_degrees / 2.0)
	
	# Calculate y-offset using trigonometry
	# tan(angle) = opposite/adjacent, so opposite = adjacent * tan(angle)
	var y_offset: float = PECK_LENGTH * tan(half_angle_rad)
	
	# Build triangle: flat edge at origin, point extends to the right
	# (0, -y) = top-left, (0, +y) = bottom-left, (length, 0) = tip
	var new_polygon := PackedVector2Array([
		Vector2(0, -y_offset),
		Vector2(0, y_offset),
		Vector2(PECK_LENGTH, 0)
	])
	
	collision_shape.polygon = new_polygon


# === COOLDOWN OVERRIDE ===
# Use our computed cooldown instead of base weapon_data.cooldown
func _start_cooldown() -> void:
	can_fire = false
	
	# Use effective_cooldown (from upgrade data) instead of weapon_data.cooldown
	if effective_cooldown <= 0.0:
		can_fire = true
		return
	
	cooldown_timer.wait_time = effective_cooldown
	cooldown_timer.start()
