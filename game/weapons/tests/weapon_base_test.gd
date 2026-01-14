extends Node2D

# Reference to our test weapon child
@onready var test_weapon: TestWeapon = $TestWeapon


func _ready() -> void:
	print("\n========== WEAPON BASE TESTS ==========\n")
	
	# Run tests with a small delay between each
	# WHY: Cooldown tests need time to pass, so we use await
	await _test_initial_state()
	await _test_cooldown_blocking()
	await _test_cooldown_recovery()
	_test_level_changes()
	
	print("\n========== TESTS COMPLETE ==========\n")


func _test_initial_state() -> void:
	print("--- TEST: Initial State ---")
	print("  can_fire: ", test_weapon.can_fire, " (expected: true)")
	print("  level: ", test_weapon.level, " (expected: 1)")
	print("  damage: ", test_weapon.damage)
	print("  fire_count: ", test_weapon.fire_count, " (expected: 0)")
	await get_tree().create_timer(0.1).timeout


func _test_cooldown_blocking() -> void:
	print("\n--- TEST: Cooldown Blocking ---")
	print("  Calling try_fire() 3 times rapidly...")
	
	test_weapon.try_fire()  # Should fire
	test_weapon.try_fire()  # Should be blocked (cooldown)
	test_weapon.try_fire()  # Should be blocked (cooldown)
	
	print("  fire_count: ", test_weapon.fire_count, " (expected: 1)")
	print("  can_fire: ", test_weapon.can_fire, " (expected: false)")
	await get_tree().create_timer(0.1).timeout


func _test_cooldown_recovery() -> void:
	print("\n--- TEST: Cooldown Recovery ---")
	print("  Waiting for cooldown (0.5s)...")
	
	# Wait longer than cooldown (peck.tres has 0.5s cooldown)
	await get_tree().create_timer(0.6).timeout
	
	print("  can_fire after wait: ", test_weapon.can_fire, " (expected: true)")
	
	# Should be able to fire again
	test_weapon.try_fire()
	print("  fire_count after 2nd fire: ", test_weapon.fire_count, " (expected: 2)")
	await get_tree().create_timer(0.1).timeout


func _test_level_changes() -> void:
	print("\n--- TEST: Level Changes ---")
	
	# Test each level and log the damage
	# Peck upgrades: L1=10, L2=15, L3=20, L4=25, L5=35
	for lvl in range(1, 6):
		test_weapon.set_level(lvl)
		print("  Level ", lvl, " -> damage: ", test_weapon.damage)
	
	# Test clamping (should stay at 5)
	test_weapon.set_level(99)
	print("  Level 99 (clamped) -> level: ", test_weapon.level, " (expected: 5)")
	
	# Test going back down
	test_weapon.set_level(1)
	print("  Back to Level 1 -> damage: ", test_weapon.damage)
