extends Node2D

# Profiling configuration
const TEST_DURATION := 60.0  # Run test for 60 seconds
var test_timer := 0.0
var fps_samples: Array[float] = []
var frame_time_samples: Array[float] = []
var last_logged_second := -1  # Track when we last logged physics


# Reference to the enemy pool config
@export var enemy_pool_config: PoolConfig

func _ready() -> void:
	# Register and warm up the enemy pool before spawning
	if enemy_pool_config:
		PoolManager.register_pool(enemy_pool_config)
		PoolManager.preload_all()
		print("Enemy pool ready: ", PoolManager.get_pool_stats("enemy_test"))
	
	print("Starting 60-second performance test...")


func _process(delta: float) -> void:
	test_timer += delta
	
	# Collect performance metrics every frame
	if test_timer < TEST_DURATION:
		# Get current FPS and frame time from Godot's Performance monitor
		var current_fps = Performance.get_monitor(Performance.TIME_FPS)
		var current_frame_time = Performance.get_monitor(Performance.TIME_PROCESS) * 1000.0  # Convert to ms
		
		fps_samples.append(current_fps)
		frame_time_samples.append(current_frame_time)
	
		# Log physics object count every 5 seconds for reference
		var current_second = int(test_timer)
		if current_second % 5 == 0 and current_second != last_logged_second:
			var physics_objects = Performance.get_monitor(Performance.PHYSICS_2D_ACTIVE_OBJECTS)
			print("T+%.0fs: Active Physics Objects: %d" % [test_timer, physics_objects])
			last_logged_second = current_second

	elif test_timer >= TEST_DURATION and fps_samples.size() > 0:
		# Test complete - calculate and log results
		_log_results()
		set_process(false)  # Stop processing after logging




func _log_results() -> void:
	# Calculate averages
	var avg_fps = _calculate_average(fps_samples)
	var avg_frame_time = _calculate_average(frame_time_samples)
	var max_frame_time = frame_time_samples.max()
	var min_fps = fps_samples.min()
	
	# Log to console
	print("\n=== PERFORMANCE TEST RESULTS (60s) ===")
	print("Average FPS: %.2f" % avg_fps)
	print("Min FPS: %.2f" % min_fps)
	print("Average Frame Time: %.2f ms" % avg_frame_time)
	print("Max Frame Time: %.2f ms" % max_frame_time)
	print("Total Samples: %d" % fps_samples.size())
	
	# Check pass/fail criteria
	var passed = avg_fps >= 60.0 and avg_frame_time <= 20.0
	print("TEST STATUS: %s" % ("PASS ✓" if passed else "FAIL ✗"))
	print("Target: 60 FPS avg, <20ms frame time")
	print("=======================================\n")


func _calculate_average(samples: Array[float]) -> float:
	if samples.is_empty():
		return 0.0
	
	var sum = 0.0
	for value in samples:
		sum += value
	
	return sum / samples.size()
