extends Node

var win_count := 0

func _ready() -> void:
	# format_time: pure, pass arbitrary values
	for s in [0, 59, 60, 61, 1799, 1800]:
		print(s, " -> ", GameTimer.format_time(s))

	# is_gameplay_active: true only while ACTIVE
	GameTimer.reset_run()
	print("active at start: ", GameTimer.is_gameplay_active())
	GameTimer.win_run()
	print("active after win: ", GameTimer.is_gameplay_active())
	GameTimer.lose_run() # guard should keep it WON, still inactive
	print("active after lose attempt: ", GameTimer.is_gameplay_active())

func _on_run_won() -> void:
	win_count += 1
	print("run_won fired! count=", win_count, " elapsed=", GameTimer.elapsed_time)
