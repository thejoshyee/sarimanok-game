extends Node2D

# === PRELOAD WEAPON DATA ===
# These are the .tres resource files that define each weapon's stats
var peck_data: WeaponData = preload("res://weapons/data/peck.tres")
var wing_slap_data: WeaponData = preload("res://weapons/data/wing_slap.tres")
var feather_shot_data: WeaponData = preload("res://weapons/data/feather_shot.tres")
var spiral_feathers_data: WeaponData = preload("res://weapons/data/spiral_feathers.tres")
var ice_shard_data: WeaponData = preload("res://weapons/data/ice_shard.tres")
var flame_wing_data: WeaponData = preload("res://weapons/data/flame_wing.tres")

# Reference to the WeaponManager (child of Player)
@onready var weapon_manager: WeaponManager = $SarimanokPlayer/WeaponManager


func _ready() -> void:
	print("=== WeaponManager Test Starting ===")
	_test_add_weapons()
	_test_limit_enforcement()
	_test_query_and_upgrade()
	print("=== WeaponManager Test Complete ===")


func _test_add_weapons() -> void:
	print("\n--- Test: Adding Weapons ---")
	
	# Peck is already added by Player at startup, so this should fail (duplicate)
	# The other 3 should succeed
	var results := [
		weapon_manager.add_weapon(peck_data),  # Should be FALSE (duplicate)
		weapon_manager.add_weapon(wing_slap_data),
		weapon_manager.add_weapon(feather_shot_data),
		weapon_manager.add_weapon(spiral_feathers_data),
	]
	
	# Log results
	print("Added peck (should be false - duplicate): ", results[0])
	print("Added wing_slap: ", results[1])
	print("Added feather_shot: ", results[2])
	print("Added spiral_feathers: ", results[3])
	print("Current weapon count: ", weapon_manager._get_weapon_count())



func _test_limit_enforcement() -> void:
	print("\n--- Test: 6-Weapon Limit ---")
	
	# We already have 4 weapons. Add 2 more to hit the limit.
	weapon_manager.add_weapon(ice_shard_data)
	weapon_manager.add_weapon(flame_wing_data)
	print("After adding 6 weapons, count: ", weapon_manager._get_weapon_count())
	
	# Now try to add a 7th - should fail and return false
	# We'll try adding peck again (duplicate weapon attempt)
	var seventh_result := weapon_manager.add_weapon(peck_data)
	print("Attempted 7th weapon (should be false): ", seventh_result)
	print("Final weapon count (should still be 6): ", weapon_manager._get_weapon_count())


func _test_query_and_upgrade() -> void:
	print("\n--- Test: Query & Upgrade ---")
	
	# Test get_weapon_by_id - should find peck
	var peck_weapon := weapon_manager.get_weapon_by_id("peck")
	print("Found peck weapon: ", peck_weapon != null)
	print("Peck current level: ", str(peck_weapon.level) if peck_weapon else "N/A")
	
	# Test upgrade_weapon
	var upgrade_result := weapon_manager.upgrade_weapon("peck")
	print("Upgrade peck (should be true): ", upgrade_result)
	print("Peck level after upgrade: ", str(peck_weapon.level) if peck_weapon else "N/A")
	
	# Test querying non-existent weapon
	var fake_weapon := weapon_manager.get_weapon_by_id("banana_launcher")
	print("Found fake weapon (should be null): ", fake_weapon)
