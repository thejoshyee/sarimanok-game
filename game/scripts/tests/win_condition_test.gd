extends Node

var win_count := 0

func _ready() -> void:
	GameTimer.run_won.connect(_on_run_won)
	GameTimer.reset_run()
	GameTimer.debug_skip_minutes(30)

func _on_run_won() -> void:
	win_count += 1
	print("run_won fired! count=", win_count, " elapsed=", GameTimer.elapsed_time)
