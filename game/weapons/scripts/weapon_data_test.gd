extends Node

# === WEAPON DATA PATHS ===
# Hardcoded list of all weapon .tres files to test
# WHY hardcoded: Explicit list is clearer than directory scanning,
# and we know exactly which 6 weapons exist in MVP scope
const WEAPON_PATHS: Array[String] = [
	"res://weapons/data/peck.tres",
	"res://weapons/data/wing_slap.tres",
	"res://weapons/data/feather_shot.tres",
	"res://weapons/data/spiral_feathers.tres",
	"res://weapons/data/ice_shard.tres",
	"res://weapons/data/flame_wing.tres",
]

func _ready() -> void:
	print("\n========== WEAPON DATA TEST ==========")
	run_all_tests()
	print("========== TEST COMPLETE ==========\n")


func run_all_tests() -> void:
	test_load_and_log_weapons()
	test_validate_fields()
	test_get_upgrade()


func test_load_and_log_weapons() -> void:
	print("\n--- Loading & Logging Weapons ---")
	
	for path in WEAPON_PATHS:
		# load() returns the resource, or null if it fails
		var weapon: WeaponData = load(path)
		
		if weapon == null:
			push_error("FAILED to load: " + path)
			continue
		
		# Log key fields for visual inspection
		print("✓ %s | type: %s | dmg: %.0f | cd: %.2fs | upgrades: %d" % [
			weapon.id,
			weapon.weapon_type,
			weapon.base_damage,
			weapon.cooldown,
			weapon.upgrades.size()
		])


func test_validate_fields() -> void:
	print("\n--- Validating Required Fields ---")
	var errors_found := 0
	
	for path in WEAPON_PATHS:
		var weapon: WeaponData = load(path)
		if weapon == null:
			continue  # Already reported in load test
		
		# Check each required field and log warnings
		if weapon.id.is_empty():
			push_warning("%s: id is empty" % path)
			errors_found += 1
		
		if weapon.display_name.is_empty():
			push_warning("%s: display_name is empty" % path)
			errors_found += 1
		
		# New - orbital weapons don't use cooldowns:
		if weapon.cooldown <= 0 and weapon.weapon_type != "orbital":
			push_warning("%s: cooldown must be > 0 (got %.2f)" % [path, weapon.cooldown])
			errors_found += 1
		
		if weapon.upgrades.is_empty():
			push_warning("%s: upgrades array is empty" % path)
			errors_found += 1
	
	# Summary
	if errors_found == 0:
		print("✓ All validations passed!")
	else:
		print("✗ Found %d validation error(s)" % errors_found)


func test_get_upgrade() -> void:
	print("\n--- Testing get_upgrade() ---")
	
	for path in WEAPON_PATHS:
		var weapon: WeaponData = load(path)
		if weapon == null:
			continue
		
		print("%s upgrades:" % weapon.id)
		
		# Test levels 1-5 (our standard upgrade range)
		for level in range(1, 6):
			var upgrade: Dictionary = weapon.get_upgrade(level)
			
			if upgrade.is_empty():
				print("  Lv%d: (none)" % level)
			else:
				# Show damage and effect description if they exist
				var dmg = upgrade.get("damage", "?")
				var effect = upgrade.get("effect_description", "")
				print("  Lv%d: %s dmg - %s" % [level, dmg, effect])
		
		# Test level 6 (should return empty - undefined level)
		var invalid: Dictionary = weapon.get_upgrade(6)
		if invalid.is_empty():
			print("  Lv6: ✓ Correctly returns empty dict")
		else:
			push_warning("%s: get_upgrade(6) should return empty dict!" % weapon.id)
