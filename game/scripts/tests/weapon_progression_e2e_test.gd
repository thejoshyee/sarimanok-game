extends Node2D

# === WEAPON PROGRESSION E2E TEST ===
# Verifies the full weapon progression flow:
# 1. Peck starts at level 1
# 2. New + upgrade choices offered when <6 weapons
# 3. Only upgrades offered at 6 weapons (no "new" type)
# 4. Max-level weapons excluded from choices
# 5. Capacity enforcement (can't exceed 6)

# Reference to WeaponManager (child of Player)
@onready var weapon_manager: WeaponManager = $SarimanokPlayer/WeaponManager

var pass_count: int = 0
var fail_count: int = 0


func _ready() -> void:
	# Wait one frame so Player._ready() runs first (grants Peck)
	await get_tree().process_frame
	
	print("\n========================================")
	print("  WEAPON PROGRESSION E2E TEST")
	print("========================================\n")
	
	_test_peck_starts_at_level_1()
	_test_choices_with_room_for_new()
	_test_choices_at_full_capacity()
	_test_max_level_excluded()
	_test_capacity_enforcement()
	
	print("\n========================================")
	print("  RESULTS: %d PASSED, %d FAILED" % [pass_count, fail_count])
	print("========================================\n")


# --- Helper: assert with PASS/FAIL logging ---
func assert_true(condition: bool, message: String) -> void:
	if condition:
		pass_count += 1
		print("  PASS: ", message)
	else:
		fail_count += 1
		print("  FAIL: ", message)


func assert_equal(actual, expected, message: String) -> void:
	if actual == expected:
		pass_count += 1
		print("  PASS: ", message)
	else:
		fail_count += 1
		print("  FAIL: %s (expected %s, got %s)" % [message, str(expected), str(actual)])


# === TEST 1: Peck starts at level 1 ===
func _test_peck_starts_at_level_1() -> void:
	print("--- Test 1: Peck Starts at Level 1 ---")
	var peck = weapon_manager.get_weapon_by_id("peck")
	assert_true(peck != null, "Peck weapon exists at game start")
	if peck:
		assert_equal(peck.level, 1, "Peck starts at level 1")
	assert_equal(weapon_manager._get_weapon_count(), 1, "Only 1 weapon at start")


# === TEST 2: Choices include new + upgrades when <6 weapons ===
func _test_choices_with_room_for_new() -> void:
	print("\n--- Test 2: Choices With Room for New Weapons ---")
	# Player has 1 weapon (Peck), so choices should include "new" options
	var choices = WeaponDatabase.get_level_up_choices(weapon_manager, 3)
	
	assert_true(choices.size() > 0, "At least 1 choice offered")
	assert_true(choices.size() <= 3, "At most 3 choices offered")
	
	# Check that at least one "new" type exists (5 unowned weapons available)
	var has_new = false
	var has_upgrade = false
	for choice in choices:
		if choice.type == "new":
			has_new = true
		elif choice.type == "upgrade":
			has_upgrade = true
	
	assert_true(has_new, "New weapon choices available when <6 weapons")
	# Peck is level 1, so upgrade should also be available
	assert_true(has_upgrade, "Upgrade choices available for owned weapons")


# === TEST 3: Only upgrades at full capacity (6 weapons) ===
func _test_choices_at_full_capacity() -> void:
	print("\n--- Test 3: Only Upgrades at Full Capacity ---")
	# Fill all 6 slots
	var all_weapons = WeaponDatabase.get_all_weapons()
	for data in all_weapons:
		if weapon_manager.get_weapon_by_id(data.id) == null:
			weapon_manager.add_weapon(data)
	
	assert_equal(weapon_manager._get_weapon_count(), 6, "All 6 weapon slots filled")
	
	# Now get choices — should be ALL upgrades, no "new"
	var choices = WeaponDatabase.get_level_up_choices(weapon_manager, 3)
	
	var new_count = 0
	for choice in choices:
		if choice.type == "new":
			new_count += 1
	
	assert_equal(new_count, 0, "No 'new' choices when at 6 weapons")
	assert_true(choices.size() > 0, "Upgrade choices still available at full capacity")


# === TEST 4: Max-level weapons excluded from choices ===
func _test_max_level_excluded() -> void:
	print("\n--- Test 4: Max-Level Weapons Excluded ---")
	# Max out ALL weapons to level 5
	for data in WeaponDatabase.get_all_weapons():
		var weapon = weapon_manager.get_weapon_by_id(data.id)
		if weapon:
			# Set to level 5 (max)
			weapon.set_level(5)
	
	# All weapons at max level → no choices should be available
	var choices = WeaponDatabase.get_level_up_choices(weapon_manager, 3)
	assert_equal(choices.size(), 0, "No choices when all weapons at max level 5")
	
	# Verify the filter works — upgradeable list should be empty
	var upgradeable = WeaponDatabase.get_upgradeable_weapons(weapon_manager)
	assert_equal(upgradeable.size(), 0, "No upgradeable weapons when all at max")


# === TEST 5: Capacity enforcement ===
func _test_capacity_enforcement() -> void:
	print("\n--- Test 5: Capacity Enforcement ---")
	# Already at 6 weapons — try to add another (should fail)
	var extra_data = WeaponDatabase.get_weapon_by_id("peck")
	var result = weapon_manager.add_weapon(extra_data)
	assert_true(!result, "Cannot add duplicate weapon")
	assert_equal(weapon_manager._get_weapon_count(), 6, "Count stays at 6 after failed add")
