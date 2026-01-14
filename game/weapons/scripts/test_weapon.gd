class_name TestWeapon
extends Weapon

# === TEST TRACKING ===
# Counts how many times _do_fire() actually executed
# WHY: We can compare fire_count to try_fire() call count
#      to verify cooldown is blocking correctly
var fire_count: int = 0


# Override _do_fire to log and track when firing happens
func _do_fire() -> bool:
	fire_count += 1
	print("[TestWeapon] FIRED! Count: ", fire_count, " | Damage: ", damage)
	return true  # Always succeeds, triggering cooldown


# Override to log stat changes for verification
func _on_stats_changed(upgrade: Dictionary) -> void:
	print("[TestWeapon] Stats changed - Level: ", level, " | Damage: ", damage)
	if not upgrade.is_empty():
		print("  Upgrade data: ", upgrade)
