extends Node

# Scaling functions for enemy stats - called globally by enemies
# WHY: Enemies need to scale HP/damage based on game time
# These are in an autoload so any enemy can call SpawnManager.get_scaled_hp()

func get_scaled_hp(base_hp: int, elapsed_minutes: float) -> int:
	# +5% HP per 5 minutes for progressive difficulty
	var scale = 1.0 + (elapsed_minutes / 5.0) * 0.05
	return int(base_hp * scale)

func get_scaled_damage(base_damage: int, elapsed_minutes: float) -> int:
	# +3% damage per 5 minutes (slower than HP scaling)
	var scale = 1.0 + (elapsed_minutes / 5.0) * 0.03
	return int(base_damage * scale)

func get_elapsed_minutes() -> float:
	return GameTimer.elapsed_minutes
