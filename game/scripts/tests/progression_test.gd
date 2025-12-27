extends Node

@onready var player = $SarimanokPlayer
@onready var level_up_panel = $LevelUpPanel


func spawn_xp_gems() -> void:
	# spawn 20 xp gems in a 4x5 grid around player
	var gem_spacing = 60 # 60px apart
	var start_x = 180 # left of player
	var start_y = 60 # top of screen

	for row in range(5):
		for col in range(4):
			var gem_pos = Vector2(start_x + col * gem_spacing, start_y + row * gem_spacing)
			PoolManager.spawn("pickup_xp_gem", gem_pos)


func print_test_header() -> void:
	print("\n=== PROGRESSION TEST START ===")
	print("Starting Level: ", ProgressionManager.current_level)
	print("Starting XP: ", ProgressionManager.current_xp)
	print("20 XP gems spawned (10 XP each = 200 total)")
	print("Expected: Reach level 3 (120 + 280 = 400 XP needed)")
	print("Move player to collect gems...")    


func _ready():
	# Register XP gem pool before spawning
	var xp_gem_config = load("res://resources/xp_gem_pool.tres")
	PoolManager.register_pool(xp_gem_config)
	PoolManager.preload_all() # warm up the pool

	spawn_xp_gems()
	print_test_header()
	connect_progression_signals()


func connect_progression_signals() -> void:
	# monitor level-ups as they happen
	ProgressionManager.level_up.connect(_on_level_up)
	ProgressionManager.level_up.connect(level_up_panel.show_level_up.bind())


func _on_level_up(new_level: int) -> void:
	print("\n🎉 LEVEL UP! Now level ", new_level)
	print("Current XP: ", ProgressionManager.current_xp)
	print("XP to next level: ", ProgressionManager.get_xp_for_level(new_level))


func _process(_delta:) -> void:
	# check for esc key to print current test state
	if Input.is_action_just_pressed("ui_cancel"):
		print_current_state()


func print_current_state():
	print("\n=== CURRENT TEST STATE ===")
	print("Level: ", ProgressionManager.current_level)
	print("XP: ", ProgressionManager.current_xp, "/", ProgressionManager.get_xp_for_level(ProgressionManager.current_level + 1))
	print("Player Stats:")
	print("  Move Speed: ", player.stats.move_speed)
	print("  Max HP: ", player.stats.max_hp)
	print("Press ESC anytime to see current state")
