extends Node2D

# === PASSIVE STAT APPLICATION TEST ===
# Verifies all 4 passives produce correct values at each level,
# independently and combined. Tests both PassiveManager math
# and player.gd integration (HP, speed, pickup range).
#
# Expected values (from .tres files):
#   Iron Beak:      +10% damage/level  → lv5 modifier = 1.5
#   Thick Plumage:  +15 HP/level       → lv5 bonus = 75 (total HP = 175)
#   Racing Legs:    +10% speed/level   → lv5 modifier = 1.5
#   Magnetic Aura:  +20% range/level   → lv5 modifier = 2.0

@onready var player = $SarimanokPlayer

var pass_count: int = 0
var fail_count: int = 0


func _ready() -> void:
	# Wait one frame so Player._ready() runs
	await get_tree().process_frame

	print("\n========================================")
	print("  PASSIVE STAT APPLICATION TEST")
	print("========================================\n")

	_test_iron_beak_independent()
	_test_thick_plumage_independent()
	_test_racing_legs_independent()
	_test_magnetic_aura_independent()
	_test_all_combined()

	print("\n========================================")
	print("  RESULTS: %d PASSED, %d FAILED" % [pass_count, fail_count])
	print("========================================\n")


# --- Helpers ---
func assert_approx(actual: float, expected: float, message: String, tolerance: float = 0.01) -> void:
	if abs(actual - expected) <= tolerance:
		pass_count += 1
		print("  PASS: %s (%.2f)" % [message, actual])
	else:
		fail_count += 1
		print("  FAIL: %s (expected %.2f, got %.2f)" % [message, expected, actual])


func _reset_passives() -> void:
	PassiveManager.reset_run()


func _max_passive(passive_id: String) -> void:
	# Upgrade to level 5
	for i in range(5):
		PassiveManager.upgrade_passive(passive_id)


# === TEST 1: Iron Beak (damage modifier) ===
func _test_iron_beak_independent() -> void:
	print("--- Iron Beak: +10% damage per level ---")
	_reset_passives()

	# Level 0: modifier should be 1.0 (no bonus)
	assert_approx(PassiveManager.get_modifier("iron_beak"), 1.0, "lv0: modifier = 1.0")

	# Level up to 5 and check modifier at each level
	for lv in range(1, 6):
		PassiveManager.upgrade_passive("iron_beak")
		var expected = 1.0 + (lv * 0.1)
		assert_approx(PassiveManager.get_modifier("iron_beak"), expected, "lv%d: modifier = %.1f" % [lv, expected])

	print("")


# === TEST 2: Thick Plumage (flat HP bonus) ===
func _test_thick_plumage_independent() -> void:
	print("--- Thick Plumage: +15 HP per level ---")
	_reset_passives()

	# Base HP should be 100
	assert_approx(player.get_effective_max_hp(), 100.0, "lv0: max HP = 100")

	# Level to 5, check HP at each level
	for lv in range(1, 6):
		PassiveManager.upgrade_passive("thick_plumage")
		var expected_hp = 100.0 + (lv * 15.0)
		assert_approx(player.get_effective_max_hp(), expected_hp, "lv%d: max HP = %.0f" % [lv, expected_hp])

	# Final: lv5 should be 175
	assert_approx(player.get_effective_max_hp(), 175.0, "lv5: total HP = 175")

	# current_hp should have scaled up too (passive_upgraded adds bonus each level)
	assert_approx(player.current_hp, 175.0, "lv5: current HP scaled to 175")
	print("")


# === TEST 3: Racing Legs (speed modifier) ===
func _test_racing_legs_independent() -> void:
	print("--- Racing Legs: +10% speed per level ---")
	_reset_passives()

	# Base speed modifier should be 1.0
	assert_approx(PassiveManager.get_modifier("racing_legs"), 1.0, "lv0: modifier = 1.0")

	_max_passive("racing_legs")
	assert_approx(PassiveManager.get_modifier("racing_legs"), 1.5, "lv5: modifier = 1.5")

	# Player effective speed = base (200) * 1.5 = 300
	# We check the modifier since velocity depends on input
	var effective_speed = player.stats.move_speed * PassiveManager.get_modifier("racing_legs")
	assert_approx(effective_speed, 300.0, "lv5: effective speed = 300")
	print("")


# === TEST 4: Magnetic Aura (pickup range modifier) ===
func _test_magnetic_aura_independent() -> void:
	print("--- Magnetic Aura: +20% pickup range per level ---")
	_reset_passives()

	# Reset pickup range to base
	player._update_pickup_range()
	assert_approx(player.pickup_shape.radius, 50.0, "lv0: pickup radius = 50")

	_max_passive("magnetic_aura")
	# Pickup range should update reactively via _on_passive_upgraded
	assert_approx(player.pickup_shape.radius, 100.0, "lv5: pickup radius = 100")

	# Verify modifier math: base 50 * 2.0 = 100
	assert_approx(PassiveManager.get_modifier("magnetic_aura"), 2.0, "lv5: modifier = 2.0")
	print("")


# === TEST 5: All passives combined ===
func _test_all_combined() -> void:
	print("--- All Passives at lv5 (combined) ---")
	_reset_passives()

	# Reset player HP to base
	player.current_hp = player.get_effective_max_hp()

	# Max all 4 passives
	_max_passive("iron_beak")
	_max_passive("thick_plumage")
	_max_passive("racing_legs")
	_max_passive("magnetic_aura")

	# Verify each passive independently still correct when all active
	assert_approx(PassiveManager.get_modifier("iron_beak"), 1.5, "combined: iron_beak modifier = 1.5")
	assert_approx(player.get_effective_max_hp(), 175.0, "combined: max HP = 175")
	assert_approx(PassiveManager.get_modifier("racing_legs"), 1.5, "combined: racing_legs modifier = 1.5")
	assert_approx(player.pickup_shape.radius, 100.0, "combined: pickup radius = 100")

	# Effective speed
	var effective_speed = player.stats.move_speed * PassiveManager.get_modifier("racing_legs")
	assert_approx(effective_speed, 300.0, "combined: effective speed = 300")

	# No interference between passives
	assert_approx(PassiveManager.get_bonus("iron_beak"), 0.5, "combined: iron_beak bonus = 0.5")
	assert_approx(PassiveManager.get_bonus("thick_plumage"), 75.0, "combined: thick_plumage bonus = 75")
	assert_approx(PassiveManager.get_bonus("racing_legs"), 0.5, "combined: racing_legs bonus = 0.5")
	assert_approx(PassiveManager.get_bonus("magnetic_aura"), 1.0, "combined: magnetic_aura bonus = 1.0")
	print("")
