extends Node2D

# === LEVEL-UP POOL SCENARIO TEST ===
# Tests LevelUpManager.get_choices() across game stages:
# 1. Early game: 1 weapon, all passives level 0
# 2. Mid game: mixed weapons/passives, some leveled
# 3. Late game: 6 weapons, many maxed
# 4. Edge case: everything maxed → empty pool
# 5. Type field verification (new_weapon / upgrade_weapon / upgrade_passive)

@onready var weapon_manager: WeaponManager = $SarimanokPlayer/WeaponManager

var pass_count: int = 0
var fail_count: int = 0


func _ready() -> void:
	# Wait one frame so Player._ready() runs (grants Peck)
	await get_tree().process_frame

	# Wire LevelUpManager to our weapon_manager
	LevelUpManager.weapon_manager = weapon_manager

	print("\n========================================")
	print("  LEVEL-UP POOL SCENARIO TEST")
	print("========================================\n")

	_test_early_game()
	_test_mid_game()
	_test_late_game()
	_test_edge_case_all_maxed()
	_test_type_field_values()

	print("\n========================================")
	print("  RESULTS: %d PASSED, %d FAILED" % [pass_count, fail_count])
	print("========================================\n")


# --- Helpers ---
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


# Reset weapons to just Peck at level 1, all passives to 0
func _reset_to_clean_state() -> void:
	# Remove all weapons except Peck
	for i in range(WeaponManager.MAX_WEAPONS):
		var w = weapon_manager.weapon_slots[i]
		if w != null and w.weapon_data.id != "peck":
			w.queue_free()
			weapon_manager.weapon_slots[i] = null
	# Reset Peck to level 1
	var peck = weapon_manager.get_weapon_by_id("peck")
	if peck:
		peck.set_level(1)
	# Reset all passives
	PassiveManager.reset()


# === TEST 1: Early Game ===
func _test_early_game() -> void:
	print("--- Test 1: Early Game (1 weapon, passives at 0) ---")
	_reset_to_clean_state()

	var choices = LevelUpManager.get_choices(3)
	assert_equal(choices.size(), 3, "3 choices offered in early game")

	# Count types — should have mix of new weapons, upgrades, and passives
	var types = { "new_weapon": 0, "upgrade_weapon": 0, "upgrade_passive": 0 }
	for c in choices:
		types[c.type] = types.get(c.type, 0) + 1

	# All choices should have valid types
	var total = types["new_weapon"] + types["upgrade_weapon"] + types["upgrade_passive"]
	assert_equal(total, 3, "All choices have valid types")

	# Build full pool by requesting more than available
	# Pool: 1 upgrade_weapon (Peck) + 5 new_weapons + 4 upgrade_passives = 10
	var full_pool = LevelUpManager.get_choices(99)
	assert_equal(full_pool.size(), 10, "Full pool = 1 upgrade + 5 new + 4 passives = 10")
	print("")


# === TEST 2: Mid Game ===
func _test_mid_game() -> void:
	print("--- Test 2: Mid Game (3 weapons, mixed levels, some passives) ---")
	_reset_to_clean_state()

	# Add 2 more weapons (3 total, 3 slots open)
	var wing_slap = WeaponDatabase.get_weapon_by_id("wing_slap")
	var feather_shot = WeaponDatabase.get_weapon_by_id("feather_shot")
	weapon_manager.add_weapon(wing_slap)
	weapon_manager.add_weapon(feather_shot)

	# Max out Peck (level 5) — should be excluded from upgrades
	var peck = weapon_manager.get_weapon_by_id("peck")
	peck.set_level(5)

	# Level up wing_slap to 3 — still upgradeable
	var ws = weapon_manager.get_weapon_by_id("wing_slap")
	ws.set_level(3)

	# Level up 2 passives partially
	PassiveManager.upgrade_passive("iron_beak")     # level 1
	PassiveManager.upgrade_passive("iron_beak")     # level 2
	PassiveManager.upgrade_passive("thick_plumage") # level 1

	var full_pool = LevelUpManager.get_choices(99)

	# Expected pool:
	# upgrade_weapon: wing_slap (lv3), feather_shot (lv1) = 2
	# new_weapon: spiral_feathers, ice_shard, flame_wing = 3
	# upgrade_passive: all 4 still below max = 4
	# Total = 9

	var has_peck_upgrade = false
	for c in full_pool:
		if c.type == "upgrade_weapon" and c.data.id == "peck":
			has_peck_upgrade = true
	assert_true(!has_peck_upgrade, "Maxed Peck excluded from upgrade pool")

	var new_count = 0
	var upgrade_count = 0
	var passive_count = 0
	for c in full_pool:
		if c.type == "new_weapon":
			new_count += 1
		elif c.type == "upgrade_weapon":
			upgrade_count += 1
		elif c.type == "upgrade_passive":
			passive_count += 1

	assert_equal(new_count, 3, "3 new weapons available (3 open slots)")
	assert_equal(upgrade_count, 2, "2 weapon upgrades (wing_slap + feather_shot)")
	assert_equal(passive_count, 4, "4 passive upgrades available")
	assert_equal(full_pool.size(), 9, "Mid-game pool = 2 + 3 + 4 = 9")
	print("")


# === TEST 3: Late Game ===
func _test_late_game() -> void:
	print("--- Test 3: Late Game (6 weapons, slots full) ---")
	_reset_to_clean_state()

	# Fill all 6 weapon slots
	for data in WeaponDatabase.get_all_weapons():
		if weapon_manager.get_weapon_by_id(data.id) == null:
			weapon_manager.add_weapon(data)
	assert_equal(weapon_manager._get_weapon_count(), 6, "All 6 slots filled")

	# Max out 4 weapons, leave spiral_feathers + flame_wing upgradeable
	for data in WeaponDatabase.get_all_weapons():
		var w = weapon_manager.get_weapon_by_id(data.id)
		if w and data.id != "spiral_feathers" and data.id != "flame_wing":
			w.set_level(5)

	# Max out 2 passives (iron_beak + thick_plumage)
	for i in range(5):
		PassiveManager.upgrade_passive("iron_beak")
		PassiveManager.upgrade_passive("thick_plumage")

	var full_pool = LevelUpManager.get_choices(99)

	# Expected:
	# upgrade_weapon: spiral_feathers(lv1) + flame_wing(lv1) = 2
	# new_weapon: 0 (slots full)
	# upgrade_passive: racing_legs(0/5) + magnetic_aura(0/5) = 2
	# Total = 4

	var new_count = 0
	for c in full_pool:
		if c.type == "new_weapon":
			new_count += 1
	assert_equal(new_count, 0, "No new weapons when slots full")
	assert_equal(full_pool.size(), 4, "Late-game pool = 2 upgrades + 0 new + 2 passives = 4")
	print("")


# === TEST 4: Edge Case — All Maxed ===
func _test_edge_case_all_maxed() -> void:
	print("--- Test 4: Edge Case (everything maxed -> empty pool) ---")
	_reset_to_clean_state()

	# Fill all weapon slots and max them all
	for data in WeaponDatabase.get_all_weapons():
		if weapon_manager.get_weapon_by_id(data.id) == null:
			weapon_manager.add_weapon(data)
		var w = weapon_manager.get_weapon_by_id(data.id)
		if w:
			w.set_level(5)

	# Max all passives
	for passive in PassiveManager.passives:
		for i in range(passive.max_level):
			PassiveManager.upgrade_passive(passive.id)

	var choices = LevelUpManager.get_choices(3)
	assert_equal(choices.size(), 0, "Empty pool when everything maxed")
	print("")


# === TEST 5: Type Field Verification ===
func _test_type_field_values() -> void:
	print("--- Test 5: Type Field Values (new_weapon / upgrade_weapon / upgrade_passive) ---")
	_reset_to_clean_state()

	# Early game full pool has all 3 types
	var full_pool = LevelUpManager.get_choices(99)

	var seen_types: Dictionary = {}
	for c in full_pool:
		seen_types[c.type] = true
		# Every choice must have a "data" key
		assert_true(c.has("data"), "Choice has 'data' key (type: %s)" % c.type)

	assert_true(seen_types.has("new_weapon"), "Pool contains 'new_weapon' type")
	assert_true(seen_types.has("upgrade_weapon"), "Pool contains 'upgrade_weapon' type")
	assert_true(seen_types.has("upgrade_passive"), "Pool contains 'upgrade_passive' type")

	# Verify new_weapon data is WeaponData
	for c in full_pool:
		if c.type == "new_weapon":
			assert_true(c.data is WeaponData, "new_weapon data is WeaponData")
			break

	# Verify upgrade_weapon data is WeaponData
	for c in full_pool:
		if c.type == "upgrade_weapon":
			assert_true(c.data is WeaponData, "upgrade_weapon data is WeaponData")
			break

	# Verify upgrade_passive data is PassiveData
	for c in full_pool:
		if c.type == "upgrade_passive":
			assert_true(c.data is PassiveData, "upgrade_passive data is PassiveData")
			break
	print("")
