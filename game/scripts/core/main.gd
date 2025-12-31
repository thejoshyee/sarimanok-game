extends Node2D

var _debug_key_held: bool = false  # Prevent debug key spam

# Arena dimensions (96x64 tiles at 32x32 each)
const ARENA_WIDTH: int = 3072   # 96 tiles * 32 pixels
const ARENA_HEIGHT: int = 2048  # 64 tiles * 32 pixels
const TILE_SIZE: int = 32

# Pool configurations to initialize at startup
@export var pool_configs: Array[PoolConfig] = []

@onready var level_up_panel = $LevelUpPanel

var test_gems: Array = [] # track spawned test gems

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
	print("XP gem pool stats: ", PoolManager.get_pool_stats("pickup_xp_gem"))

	# Test: Spawn 10 xp gems in a circle for pooling verification
	test_spawn_xp_gems()
	
	# Print viewport size to confirm 640×360
	var viewport_size = get_viewport().get_visible_rect().size
	print("Viewport size: ", viewport_size)
	
	# Print camera position for debugging
	print("Camera position: ", $Camera2D.position)

	# queue_redraw()  # Disabled for tilemap painting - re-enable for debug

	# Enable camera smoothing for testing
	$Camera2D.position_smoothing_enabled = true
	$Camera2D.position_smoothing_speed = 5.0

	ProgressionManager.level_up.connect(level_up_panel.show_level_up)


func _draw(show_debug_grid: bool = true):
	if not show_debug_grid:
		return
	# Draw tile grid overlay (32×32 tiles)
	var grid_color = Color(1, 1, 0, 0.3)  # Yellow, semi-transparent

	# Draw vertical lines every 32 pixels
	for x in range(0, ARENA_WIDTH + TILE_SIZE, TILE_SIZE):
		draw_line(Vector2(x, 0), Vector2(x, ARENA_HEIGHT), grid_color, 1)

	# Draw horizontal lines every 32 pixels
	for y in range(0, ARENA_HEIGHT + TILE_SIZE, TILE_SIZE):
		draw_line(Vector2(0, y), Vector2(ARENA_WIDTH, y), grid_color, 1)

	# Draw arena boundary in red
	draw_rect(Rect2(0, 0, ARENA_WIDTH, ARENA_HEIGHT), Color.RED, false, 2)


# Camera follows the player
func _process(_delta):
	# Test: Press Space to toggle XP Gems (despawn all, then respawn)
	if Input.is_action_just_pressed("ui_select"): # space bar
		if test_gems.size() > 0:
			# despawn all test gems
			for gem in test_gems:
				PoolManager.despawn(gem)
			test_gems.clear()
			print("Despawned all test gems")
		else:
			# Respawn 10 gems
			test_spawn_xp_gems()

	# DEBUG: Press 1/2/3 to skip 5/10/20 minutes (just_pressed prevents spam)
	if Input.is_physical_key_pressed(KEY_1) and not _debug_key_held:
		_debug_key_held = true
		GameTimer.debug_skip_minutes(5)
	elif Input.is_physical_key_pressed(KEY_2) and not _debug_key_held:
		_debug_key_held = true
		GameTimer.debug_skip_minutes(10)
	elif Input.is_physical_key_pressed(KEY_3) and not _debug_key_held:
		_debug_key_held = true
		GameTimer.debug_skip_minutes(20)
	elif not Input.is_physical_key_pressed(KEY_1) and not Input.is_physical_key_pressed(KEY_2) and not Input.is_physical_key_pressed(KEY_3):
		_debug_key_held = false


	# Camera follows the player
	if has_node("Player"):
		$Camera2D.position = $Player.position

	# DEBUG: Show FPS in window title
	get_window().title = "Sarimanok - FPS: " + str(Engine.get_frames_per_second())



func test_spawn_xp_gems():
	# spawn 10 xp gems in a circle pattern around player for test
	var player_pos = $Player.position if has_node("Player") else Vector2(320, 180)
	var radius = 100.0 

	for i in range(10):
		var angle = (i / 10.0) * TAU # Divide circle into 10 equal angles
		var offset = Vector2(cos(angle), sin(angle)) * radius
		var gem = PoolManager.spawn("pickup_xp_gem", player_pos + offset)
		if gem:
			test_gems.append(gem) # store reference to spawned gem
			print("Spawned XP gem #", i, " at: ", gem.global_position)

	# Print pool stats after spawning
	print("After spawn - ", PoolManager.get_pool_stats("pickup_xp_gem"))
