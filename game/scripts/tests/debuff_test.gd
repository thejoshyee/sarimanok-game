extends Node2D

# === REFERENCES ===
@onready var player: CharacterBody2D = $SarimanokPlayer

# === WEAPON DATA ===
var ice_shard_data: WeaponData = preload("res://weapons/data/ice_shard.tres")
var feather_shot_data: WeaponData = preload("res://weapons/data/feather_shot.tres")

# === ENEMY SCENE ===
# Uses real duwende with DebuffHandler (not test_enemy)
var duwende_scene: PackedScene = preload("res://scenes/enemies/duwende/enemy_duwende.tscn")

# === POOL CONFIG ===
var projectile_pool_config: PoolConfig = preload("res://resources/base_projectile_pool.tres")

# Track spawned enemies for respawning
var spawned_enemies: Array = []

func _ready() -> void:
	# Register projectile pool (main.tscn does this normally)
	PoolManager.register_pool(projectile_pool_config)
	PoolManager.preload_all()
	
	# Add weapons — Ice Shard has debuff, Feather Shot does not
	var weapon_manager: WeaponManager = player.get_node("WeaponManager")
	weapon_manager.add_weapon(ice_shard_data)
	weapon_manager.add_weapon(feather_shot_data)

	_spawn_test_enemies()
	
	print("[DEBUFF TEST] Controls:")
	print("  R = Respawn enemies")
	print("  S = Print slow factors for all enemies")

func _spawn_test_enemies() -> void:
	# Spawn 3 enemies to the RIGHT at different distances
	# They move toward player so you can SEE the slow effect
	var distances := [100.0, 150.0, 200.0]
	
	for dist in distances:
		var enemy = duwende_scene.instantiate()
		enemy.position = player.position + (Vector2.RIGHT * dist)
		enemy.base_speed = 30.0  # Slow base speed so slow effect is visible
		enemy.speed = 30.0
		enemy.base_max_hp = 999
		enemy.current_hp = 999
		add_child(enemy)
		enemy.add_to_group("enemies")
		spawned_enemies.append(enemy)
	
	print("[DEBUFF TEST] Spawned %d duwende enemies (speed=30, hp=999)" % spawned_enemies.size())

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_R:
				_respawn_enemies()
			KEY_S:
				_print_slow_factors()

func _print_slow_factors() -> void:
	for i in spawned_enemies.size():
		var enemy = spawned_enemies[i]
		if is_instance_valid(enemy):
			var factor = enemy.get_total_slow_factor()
			var debuff_count = enemy.get_node("DebuffHandler").active_debuffs.size()
			print("[DEBUFF TEST] Enemy %d: slow_factor=%.2f, active_debuffs=%d" % [i, factor, debuff_count])

func _respawn_enemies() -> void:
	for enemy in spawned_enemies:
		if is_instance_valid(enemy):
			enemy.queue_free()
	spawned_enemies.clear()
	_spawn_test_enemies()
	print("[DEBUFF TEST] Enemies respawned!")
