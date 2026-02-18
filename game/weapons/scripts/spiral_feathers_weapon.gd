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

func _ready() -> void:
	# Always active — no cooldown needed
	# WHY: Spiral Feathers is a passive orbital, not a triggered weapon
	can_fire = false
	
	# Call super to load weapon_data and apply level stats
	super._ready()
	
	# Spawn the initial set of feathers around the player
	_spawn_feathers()


func _process(delta: float) -> void:
	# Follow the player every frame so orbitals stay centered
	# WHY: This weapon isn't parented to the player directly,
	#      so we track position manually
	var player := get_tree().get_first_node_in_group("player") as Node2D
	global_position = player.global_position
	
	# Spin the OrbitRoot — feathers are children of it so they spin too
	$OrbitRoot.rotation += orbit_speed * delta


func _spawn_feathers() -> void:
	# Clear any existing feathers before spawning new ones
	# Called on level-up too, so we rebuild from scratch
	for f in feathers:
		f.queue_free()
	feathers.clear()
	
	# Spawn feathers evenly spaced around a circle
	for i in range(feather_count):
		var feather := feather_scene.instantiate() as OrbitalFeather
		feather.damage = damage
		feather.weapon_data = weapon_data
		
		# TAU = 2*PI (full circle). Divide evenly by feather count.
		var angle := TAU * float(i) / float(feather_count)
		feather.position = Vector2.RIGHT.rotated(angle) * orbit_radius
		
		$OrbitRoot.add_child(feather)
		feathers.append(feather)


func try_fire() -> void:
	# Spiral Feathers is always active — it has no trigger or cooldown.
	# Overriding this prevents WeaponManager from ever calling _do_fire().
	pass
