extends Node2D

# Pool configurations to initialize at startup
@export var pool_configs: Array[PoolConfig] = []

var spawn_timer: float = 0.0
var spawn_interval: float = 3.0  # Spawn enemy every 3 seconds

# Called when the node enters the scene tree for the first time.
func _ready():
	# INITIALIZATION ORDER:
		# 1. Register all pools from pool_configs array (configured in Inspector)
		# 2. Pre-warm all pools (allocates instances before gameplay)
		# 3. Rest of scene initialization (camera, viewport, etc.)
		#
		# Other systems should use PoolManager.spawn() and PoolManager.despawn()
		# instead of instantiate() and queue_free() during gameplay

	# initialize pools before any gameplay systems start
	for config in pool_configs:
		PoolManager.register_pool(config)
	PoolManager.preload_all()
	print("Enemy pool stats: ", PoolManager.get_pool_stats("enemy_test"))
	
	# Print viewport size to confirm 640×360
	var viewport_size = get_viewport().get_visible_rect().size
	print("Viewport size: ", viewport_size)
	
	# Print camera position for debugging
	print("Camera position: ", $Camera2D.position)

	queue_redraw()

	# Enable camera smoothing for testing
	$Camera2D.position_smoothing_enabled = true
	$Camera2D.position_smoothing_speed = 5.0


func _draw():
	# Draw tile grid overlay (32×32 tiles)
	var grid_color = Color(1, 1, 0, 0.3)  # Yellow, semi-transparent
	
	# Draw vertical lines every 32 pixels
	for x in range(0, 1920 + 32, 32):
		draw_line(Vector2(x, 0), Vector2(x, 1088), grid_color, 1)
	
	# Draw horizontal lines every 32 pixels
	for y in range(0, 1088 + 32, 32):
		draw_line(Vector2(0, y), Vector2(1920, y), grid_color, 1)
	
	# Draw arena boundary in red
	draw_rect(Rect2(0, 0, 1920, 1088), Color.RED, false, 2)


# Camera follows the player
func _process(_delta):
	if has_node("Player"):
		$Camera2D.position = $Player.position

	# spawn enemies periodically
	spawn_timer += _delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_enemy()


func spawn_enemy():
	var enemy = PoolManager.spawn("enemy_test")
	if enemy:
		# spawn at random pos around player
		var player_pos = $Player.position if has_node("Player") else Vector2(320, 180)
		var angle = randf() * TAU
		var distance = randf_range(150, 250)
		enemy.global_position = player_pos + Vector2(cos(angle), sin(angle)) * distance
		print("Spawned enemy at: ", enemy.global_position)
