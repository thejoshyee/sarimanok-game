extends Node

# Total sceconds elapsed thgis run
var elapsed_time: float = 0.0

# Convenience property - most systems want minutes, not seconds
var elapsed_minutes: float:
	get:
		return elapsed_time / 60.0

func _process(delta: float) -> void:
	# accumulate time each frame
	elapsed_time += delta

func reset() -> void:
	# call this when starting a new run
	elapsed_time = 0.0
