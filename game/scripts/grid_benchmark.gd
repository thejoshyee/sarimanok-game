extends Node2D

# Benchmark configuration
const TEST_COUNTS = [100, 250, 500]
const TEST_DURATION = 10.0  # Seconds per test
const CELL_SIZES_TO_TEST = [32, 64, 96]

# Enemy spawning
@onready var enemy_scene = preload("res://scenes/enemies/test_enemy.tscn")
var active_enemies = []

# Benchmark data
var current_test_index = 0
var current_cell_size_index = 0
var test_timer = 0.0
var frame_times = []
var collision_checks = []

# Results
var benchmark_results = []

func _ready():
	print("=== Grid Benchmark Starting ===")
	start_next_test()


func start_next_test():
	# Clear previous test
	clear_enemies()
	frame_times.clear()
	collision_checks.clear()
	test_timer = 0.0
	
	# Check if all tests complete
	if current_test_index >= TEST_COUNTS.size():
		if current_cell_size_index >= CELL_SIZES_TO_TEST.size() - 1:
			print_results()
			get_tree().quit()
			return
		else:
			# Move to next cell size
			current_cell_size_index += 1
			current_test_index = 0
			GridManager.cell_size = CELL_SIZES_TO_TEST[current_cell_size_index]
			GridManager.clear()
	
	var enemy_count = TEST_COUNTS[current_test_index]
	var cell_size = CELL_SIZES_TO_TEST[current_cell_size_index]
	
	print("\n--- Testing: %d enemies, cell_size=%d ---" % [enemy_count, cell_size])
	
	# Spawn enemies in random positions
	for i in enemy_count:
		var enemy = enemy_scene.instantiate()
		enemy.position = Vector2(
			randf_range(0, 1280),
			randf_range(0, 720)
		)
		add_child(enemy)
		active_enemies.append(enemy)

func clear_enemies():
	for enemy in active_enemies:
		enemy.queue_free()
	active_enemies.clear()


func _process(delta):
	if current_test_index >= TEST_COUNTS.size():
		return
	
	test_timer += delta
	
	# Collect frame time and grid stats
	frame_times.append(delta)
	collision_checks.append(GridManager.query_count)
	
	# Check if test duration complete
	if test_timer >= TEST_DURATION:
		save_test_results()
		current_test_index += 1
		start_next_test()

func save_test_results():
	var avg_frame_time = frame_times.reduce(func(sum, val): return sum + val, 0.0) / frame_times.size()
	var avg_fps = 1.0 / avg_frame_time if avg_frame_time > 0 else 0
	var avg_checks = collision_checks.reduce(func(sum, val): return sum + val, 0) / collision_checks.size()
	
	var result = {
		"enemy_count": TEST_COUNTS[current_test_index],
		"cell_size": CELL_SIZES_TO_TEST[current_cell_size_index],
		"avg_fps": avg_fps,
		"avg_frame_time_ms": avg_frame_time * 1000.0,
		"avg_collision_checks": avg_checks,
		"grid_updates": GridManager.grid_update_count,
		"active_cells": GridManager.get_active_cell_count()
	}
	
	benchmark_results.append(result)
	
	print("  Avg FPS: %.1f" % avg_fps)
	print("  Avg Frame Time: %.2fms" % (avg_frame_time * 1000.0))
	print("  Avg Collision Checks: %d" % avg_checks)
	print("  Active Cells: %d" % result.active_cells)


func print_results():
	print("\n=== BENCHMARK RESULTS COMPLETE ===\n")
	
	for result in benchmark_results:
		print("Enemy Count: %d | Cell Size: %d" % [result.enemy_count, result.cell_size])
		print("  FPS: %.1f | Frame Time: %.2fms" % [result.avg_fps, result.avg_frame_time_ms])
		print("  Collision Checks/Frame: %d" % result.avg_collision_checks)
		print("  Grid Updates: %d | Active Cells: %d" % [result.grid_updates, result.active_cells])
		print("  ---")
	
	# Find best configuration
	var best_result = benchmark_results[0]
	for result in benchmark_results:
		if result.avg_fps > best_result.avg_fps:
			best_result = result
	
	print("\n=== RECOMMENDED CONFIGURATION ===")
	print("Cell Size: %d" % best_result.cell_size)
	print("Sustained FPS at %d enemies: %.1f" % [best_result.enemy_count, best_result.avg_fps])
	print("Average Collision Checks: %d" % best_result.avg_collision_checks)
	
	# Save to file
	save_to_file()


func save_to_file():
	# Ensure directory exists
	DirAccess.make_dir_recursive_absolute("res://test_reports")
	
	var file = FileAccess.open("res://test_reports/grid_benchmark_results.md", FileAccess.WRITE)
	if file == null:
		push_error("Failed to open file for writing: " + str(FileAccess.get_open_error()))
		return
	
	file.store_string("# Grid Benchmark Results\n\n")
	file.store_string("Date: %s\n\n" % Time.get_datetime_string_from_system())
	
	for result in benchmark_results:
		file.store_string("## %d Enemies | Cell Size: %dpx\n" % [result.enemy_count, result.cell_size])
		file.store_string("- **FPS**: %.1f\n" % result.avg_fps)
		file.store_string("- **Frame Time**: %.2fms\n" % result.avg_frame_time_ms)
		file.store_string("- **Collision Checks/Frame**: %d\n" % result.avg_collision_checks)
		file.store_string("- **Active Grid Cells**: %d\n\n" % result.active_cells)
	
	file.close()
	print("\nResults saved to test_reports/grid_benchmark_results.md")
