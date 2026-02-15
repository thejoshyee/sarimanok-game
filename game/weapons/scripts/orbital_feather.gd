class_name OrbitalFeather
extends Area2D

# === COMBAT DATA ===
# Set by the parent SpiralFeathersWeapon when spawned
var damage: int = 0
var weapon_data: WeaponData


func _ready() -> void:
	# Connect collision signals for enemy detection
	# WHY: Orbitals damage on contact, not on a cooldown
	body_entered.connect(_on_body_entered)


# === DAMAGE ===

# Applies damage to any valid target (enemies)
func _hit(target: Node) -> void:
	if target.has_method("take_damage"):
		target.take_damage(damage)


func _on_body_entered(body: Node) -> void:
	_hit(body)
