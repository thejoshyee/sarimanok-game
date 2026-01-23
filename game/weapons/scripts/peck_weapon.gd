class_name PeckWeapon
extends Weapon

# === CONSTANTS ===
const PECK_LENGTH: float = 50.0  # How far the peck reaches (pixels)
const DEFAULT_ARC_ANGLE: float = 50.0  # Default arc width in degrees


# === NODE REFERENCES ===
@onready var hit_area: Area2D = $HitArea
@onready var collision_shape: CollisionPolygon2D = $HitArea/CollisionPolygon2D
@onready var hit_visual: ColorRect = $HitVisual


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


# === FIRING ===
# Called by base Weapon.try_fire() when cooldown is ready
func _do_fire() -> bool:
	# Get player reference
	# WeaponManager is our parent, player is WeaponManager's parent
	var weapon_manager = get_parent()
	var player = weapon_manager.player
	
	# Guard: Can't fire without a valid player
	if player == null:
		return false
	
	# Rotate cone to match player facing direction
	# Use player's velocity to determine facing (moving direction)
	if player.velocity.length() > 0:
		# velocity.angle() converts velocity vector to angle in radians
		rotation = player.velocity.angle()
	# If player is stationary, keep current rotation (last facing direction)
	
	# Step 3: Detect and damage enemies in the cone
	var enemies = hit_area.get_overlapping_bodies()
	for enemy in enemies:
		# Check if this body can take damage (has the method)
		if enemy.has_method("take_damage"):
			enemy.take_damage(damage)
	
	# Step 4: Flash the visual to show attack happened
	_show_hit_flash()

	return true


# Brief visual flash when peck fires
func _show_hit_flash() -> void:
	hit_visual.visible = true
	
	# Hide after 0.1 seconds (brief flash)
	await get_tree().create_timer(0.1).timeout
	hit_visual.visible = false
