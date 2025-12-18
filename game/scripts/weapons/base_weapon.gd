extends Node
class_name BaseWeapon

# Ref to weapon manager (set when equipped)
var weapon_manager: WeaponManager

# Ref to the player (for accessing stats)]
var player: CharacterBody2D

# Slot index this weapon is equipped in (0-5)
var slot_index: int = -1

# === ABSTRACT METHODS - Must be overridden by subclasses (Child weapons) ===

func attack() -> void:
	assert(false, "attack() method must be overridden by child weapon class")

func get_base_cooldown() -> float:
	assert(false, "get_base_cooldown() method must be overridden by child weapon class")
	return 0.0

func get_base_damage() -> float:
	assert(false, "get_base_damage() method must be overridden by child weapon class")
	return 0.0

# === VIRTUAL METHODS - Optional overrides with default behavior ===

# Called when weapon is equipped to a slot
func on_equip() -> void:
	pass # no default behavior

# Called when weapon is unequipped
func on_unequip() -> void:
	pass # no default behavior

# Hook for passive modifiers to adjust weapon behavior
func apply_passive_modifiers(_modifier_name: String, _value: float) -> void:
	pass # no default behavior, weapons can override to respond to passives

# === HELPER METHODS - Concrete implementations weapons can use ===

# Calculate final damage including players damage multiplier
func get_final_damage() -> float:
	if not player:
		return get_base_damage()
	return get_base_damage() * player.stats.damage_multiplier

# calc final cooldown accounting for attack speed
func get_final_cooldown() -> float:
	if not player:
		return get_base_cooldown()
	return get_base_cooldown() / player.stats.attack_speed_multiplier

# helper to reset this weapon's cooldown after attacking
func reset_cooldown() -> void:
	if weapon_manager:
		weapon_manager.set_cooldown(slot_index, get_final_cooldown())
