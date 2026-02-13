extends Node2D

# === REFERENCES ===
@onready var player: CharacterBody2D = $SarimanokPlayer
@onready var weapon_manager: WeaponManager = $SarimanokPlayer/WeaponManager

# === WEAPON DATA ===
var feather_shot_data: WeaponData = preload("res://weapons/data/feather_shot.tres")
var ice_shard_data: WeaponData = preload("res://weapons/data/ice_shard.tres")

# === TEST ENEMY SCENE ===
var test_enemy_scene: PackedScene = preload("res://scenes/enemies/test_enemy.tscn")

# === POOL CONFIG ===
var projectile_pool_config: PoolConfig = preload("res://resources/base_projectile_pool.tres")

# Track spawned enemies for respawning
var spawned_enemies: Array = []

func _ready() -> void:
	# Register projectile pool (main.tscn does this normally, test scenes must do it manually)
	PoolManager.register_pool(projectile_pool_config)
	PoolManager.preload_all()
	
	# Add both projectile weapons
	weapon_manager.add_weapon(feather_shot_data)
	weapon_manager.add_weapon(ice_shard_data)
	print("[TEST] Added Feather Shot and Ice Shard weapons")
	
	# Spawn enemies at known distances
	_spawn_test_enemies()
	
	print("[TEST] Controls:")
	print("  1 = Upgrade Feather Shot")
	print("  2 = Upgrade Ice Shard")
	print("  R = Respawn enemies")
	print("  P = Print pool stats")


func _spawn_test_enemies() -> void:
	# Distances: test nearest-enemy targeting + pierce behavior
	# 80px = close (targeted first)
	# 120px = medium (pierce test — projectile should pass through close enemy)
	# 180px = far (tests pierce_count=3 at level 5)
	var distances := [80.0, 120.0, 180.0]
	# Line enemies up in one direction so pierce can be tested visually
	# Also add side enemies to test nearest-enemy targeting
	var directions := [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]
	
	for dist in distances:
		for dir in directions:
			var enemy = test_enemy_scene.instantiate()
			enemy.position = player.position + (dir * dist)
			enemy.speed = 0.00   # Stationary — verify debuff via print logs
			enemy.base_max_hp = 999  # Survive many hits
			enemy.hp = 999
			add_child(enemy)
			enemy.on_spawn()
			spawned_enemies.append(enemy)
	
	print("[TEST] Spawned %d enemies at distances 80/120/180px" % spawned_enemies.size())


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1:
				weapon_manager.upgrade_weapon("feather_shot")
				var w = weapon_manager.get_weapon_by_id("feather_shot")
				if w:
					print("[TEST] Feather Shot → level %d (dmg: %d, count: %d, pierce: %d)" % [w.level, w.damage, w.projectile_count, w.pierce_count])
			KEY_2:
				weapon_manager.upgrade_weapon("ice_shard")
				var w = weapon_manager.get_weapon_by_id("ice_shard")
				if w:
					print("[TEST] Ice Shard → level %d (dmg: %d, count: %d, pierce: %d)" % [w.level, w.damage, w.projectile_count, w.pierce_count])
			KEY_R:
				_respawn_enemies()
			KEY_P:
				print("[TEST] Pool stats: ", PoolManager.get_pool_stats("projectile_base"))


func _respawn_enemies() -> void:
	for enemy in spawned_enemies:
		if is_instance_valid(enemy):
			enemy.queue_free()
	spawned_enemies.clear()
	_spawn_test_enemies()
	print("[TEST] Enemies respawned!")
