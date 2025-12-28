extends Node


# Calculate scaled HP based on elapsed time
# WHY: Enemies get 5% more HP every 5 minutes for progressive difficulty
# base_hp: Starting HP value for this enemy type
# elapsed_minutes: How many minutes into the run
func get_scaled_hp(base_hp: int, elapsed_minutes: float) -> int:
	var scale = 1.0 + (elapsed_minutes / 5.0) * 0.05 # +5% per 5min
	return int(base_hp * scale)

# Calculate scaled damage based on elapsed time
# WHY: Enemies deal 3% more damage every 5 minutes (slower than HP scaling)
# base_damage: starting damage value for this enemy type
# elapsed_minutes: How many minutes into the run
func get_scaled_damage(base_damage: int, elapsed_minutes: float) -> int:
	var scale = 1.0 + (elapsed_minutes / 5.0) * 0.03 # +3% per 5min
	return int(base_damage * scale)


# Helper to get current game time from global timer
func get_elapsed_minutes() -> float:
	return GameTimer.elapsed_minutes
