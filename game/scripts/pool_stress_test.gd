extends Node2D

# Stress test configuration
@export var spawn_interval := 0.1  # Seconds between spawns
@export var max_active_enemies := 50  # Peak number of active enemies
@export var enemy_lifetime := 3.0  # How long each enemy lives before despawning
@export var pool_type := "enemy_test"  # Which pool to stress test0

var active_enemies := []
var spawn_timer := 0.0

# Performance tracking
var frame_count := 0
var fps_sample_time := 0.0
var avg_fps := 0.0
var peak_active := 0


func _ready():
	# Register and warm up the pool for this test
	var config = preload("res://resources/test_enemy_pool.tres")
	PoolManager.register_pool(config)
	PoolManager.preload_all()

	print("=== Pool Stress Test Started ===")
	print("Pool type: ", pool_type)
	print("Spawn interval: ", spawn_interval, "s")
	print("Max active: ", max_active_enemies)
	print("Enemy lifetime: ", enemy_lifetime, "s")
	print("Press F3 to see pool stats")


func _process(delta):
	spawn_timer += delta
	
	# Spawn new enemies at the configured interval
	if spawn_timer >= spawn_interval and active_enemies.size() < max_active_enemies:
		spawn_enemy()
		spawn_timer = 0.0
	
	# Check for enemies that should despawn
	cleanup_expired_enemies(delta)

	# Track performance metrics
	frame_count += 1
	fps_sample_time += delta
	peak_active = max(peak_active, active_enemies.size())
	
	# Print stats every 5 seconds
	if fps_sample_time >= 5.0:
		avg_fps = frame_count / fps_sample_time
		print("Performance: %.1f FPS | Active: %d | Peak: %d" % [avg_fps, active_enemies.size(), peak_active])
		frame_count = 0
		fps_sample_time = 0.0


func spawn_enemy():
	var enemy = PoolManager.spawn(pool_type)
	if enemy:
		# Random position on screen
		enemy.position = Vector2(
			randf_range(0, 640),
			randf_range(0, 360)
		)
		# Track this enemy with its spawn time
		active_enemies.append({
			"node": enemy,
			"time_alive": 0.0
		})
	else:
		print("WARNING: Pool exhausted!")


func cleanup_expired_enemies(delta):
	# Update time alive for each enemy and despawn expired ones
	for i in range(active_enemies.size() - 1, -1, -1):
		active_enemies[i]["time_alive"] += delta
		
		if active_enemies[i]["time_alive"] >= enemy_lifetime:
			var enemy = active_enemies[i]["node"]
			PoolManager.despawn(enemy)
			active_enemies.remove_at(i)


func _input(event):
	if event.is_action_pressed("ui_accept"):  # Space bar
		print("\n=== Current Test Summary ===")
		print("Peak active enemies: %d" % peak_active)
		print("Current avg FPS: %.1f" % avg_fps)
		var stats = PoolManager.get_pool_stats(pool_type)
		print("Pool stats: %d/%d used (max: %d)" % [stats.active, stats.total, stats.max])