extends Node

# Scaling functions for enemy stats - called globally by enemies
# WHY: Enemies need to scale HP/damage based on game time
# These are in an autoload so any enemy can call SpawnManager.get_scaled_hp()

# Spawn interval scaling constants
# WHY: Exponential formula makes spawns faster over time without ever hitting 0
var base_interval: float = 2.0 # starting spawn rate (2 seconds between spawns)
var difficulty_scale: float = 1.05 # 5% faster per minute (divisor grow exponentially)

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


func get_spawn_interval(elapsed_minutes: float) -> float:
	# Exponential decay: spawn gets faster over time but never hits 0
	# At 0 min: 2.0s, at 10 min: ~1.23s, at 20 min: ~0.75s, at 30 min: ~0.46s
	return base_interval / pow(difficulty_scale, elapsed_minutes)
