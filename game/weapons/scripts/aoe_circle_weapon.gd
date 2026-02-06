class_name AOECircleWeapon
extends Weapon


# === AOE CONFIGURATION ===
# Base radius in pixels - upgrades can modify this
@export var base_radius: float = 64.0


# === NODE REFERENCES ===
# @onready means these are set when the scene loads, not when script compiles
@onready var aoe_area: Area2D = $AOEArea
@onready var collision_shape: CollisionShape2D = $AOEArea/CollisionShape2D
@onready var placeholder: ColorRect = $Placeholder
@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	# Call parent _ready() first - sets up cooldown timer and validates weapon_data
	super._ready()


# Updates the collision circle to match the given radius
# Called from _ready() and when upgrades change the size
func _update_radius(new_radius: float) -> void:
	# Access the CircleShape2D resource and set its radius
	var circle_shape: CircleShape2D = collision_shape.shape
	circle_shape.radius = new_radius
	
	# Update placeholder visual to match (diameter = radius × 2)
	var diameter := new_radius * 2.0
	placeholder.size = Vector2(diameter, diameter)
	placeholder.position = Vector2(-new_radius, -new_radius)  # Center it


# Called by parent Weapon when level changes
# Reads upgrade data and applies AOE-specific stats
func _on_stats_changed(upgrade: Dictionary) -> void:
	# Read radius_modifier from upgrade data, fallback to existing value
	# Each level can specify a multiplier (1.0, 1.25, 1.5, etc.)
	var modifier: float = upgrade.get("radius_modifier", weapon_data.radius_modifier)
	
	# Update the WeaponData's radius_modifier so other systems can reference it
	weapon_data.radius_modifier = modifier
	
	# Calculate actual radius: base × modifier
	# Multiplier approach lets us tweak base_radius without updating all upgrades
	var actual_radius: float = base_radius * modifier
	_update_radius(actual_radius)



# Called by parent Weapon.try_fire() when cooldown is ready
# Returns true if attack happened, false if blocked
func _do_fire() -> bool:
	# Get all physics bodies currently overlapping our AOEArea
	var bodies := aoe_area.get_overlapping_bodies()
	
	# Track if we hit anything (for future "whiff" feedback)
	var _hit_something := false
	
	# Damage each enemy in range
	for body in bodies:
		# Guard: Only damage things that have a take_damage() method
		if body.has_method("take_damage"):
			body.take_damage(damage)
			_hit_something = true
	
	# Play the expand animation for visual feedback
	if anim_player.has_animation("expand"):
		anim_player.play("expand")
	
	# Always return true - AOE fires even if no enemies nearby
	return true
