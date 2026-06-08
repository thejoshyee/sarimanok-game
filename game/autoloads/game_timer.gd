extends Node

# GameTimer is the central authority for run state + win/lose signaling.

signal run_won
signal run_lost

enum RunState {ACTIVE, WON, LOST}
var run_state: RunState = RunState.ACTIVE

# Gates time accumulation in _process — stops the clock once the run ends
var run_active: bool = true

# Total seconds elapsed this run
var elapsed_time: float = 0.0

var elapsed_minutes: float:
	get:
		return elapsed_time / 60.0

func _process(delta: float) -> void:
	if not run_active:
		return
	elapsed_time += delta

func win_run() -> void:
	if run_state != RunState.ACTIVE:
		return
	run_state = RunState.WON
	run_active = false
	run_won.emit()

func lose_run() -> void:
	if run_state != RunState.ACTIVE:
		return
	run_state = RunState.LOST
	run_active = false
	run_lost.emit()

func reset_run() -> void:
	# call this when starting a new run
	elapsed_time = 0.0
	run_state = RunState.ACTIVE
	run_active = true

# DEBUG: Skip forward in time for testing scaling
# Call with: GameTimer.debug_skip_minutes(10)
func debug_skip_minutes(minutes: float) -> void:
	elapsed_time += minutes * 60.0
	print("[DEBUG] Skipped ", minutes, " minutes. Now at: ", elapsed_minutes, " min")
