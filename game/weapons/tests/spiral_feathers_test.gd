extends Node2D

## Test scene for Spiral Feathers orbital weapon
## Controls: 1-5 to set level, R to respawn enemies

# === REFERENCES ===
@onready var player: CharacterBody2D = $SarimanokPlayer
@onready var weapon_manager: WeaponManager = $SarimanokPlayer/WeaponManager

# Weapon data and scene references
var spiral_feathers_data: WeaponData = preload("res://weapons/data/spiral_feathers.tres")
var test_enemy_scene: PackedScene = preload("res://scenes/enemies/test_enemy.tscn")

var spiral_weapon: SpiralFeathersWeapon = null
var spawned_enemies: Array = []



func _ready() -> void:
	weapon_manager.add_weapon(spiral_feathers_data)
	
	# Wait a frame so weapon_slots are populated before querying
	await get_tree().process_frame
	spiral_weapon = weapon_manager.get_weapon_by_id("spiral_feathers") as SpiralFeathersWeapon
	
	_spawn_test_enemies()
	
	print("=== Spiral Feathers Test Ready ===")
	print("Controls: 1-5 = set level | R = respawn enemies")
	_print_current_stats()


func _spawn_test_enemies() -> void:
	# Spawn 4 enemies just outside the default orbit radius (32px)
	# They'll move slowly toward the player and feathers will sweep through them
	var directions := [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	var dist := 60.0
	
	for dir in directions:
		var enemy = test_enemy_scene.instantiate()
		enemy.position = player.position + (dir * dist)
		enemy.speed = 15.0       # Slow — so feathers get multiple hits
		enemy.base_max_hp = 999  # High HP so they don't die during the test
		enemy.hp = 999
		add_child(enemy)
		enemy.on_spawn()
		spawned_enemies.append(enemy)
	
	print("[TEST] Spawned %d enemies at %.0fpx distance" % [spawned_enemies.size(), dist])


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1: _set_level(1)
			KEY_2: _set_level(2)
			KEY_3: _set_level(3)
			KEY_4: _set_level(4)
			KEY_5: _set_level(5)
			KEY_R: _respawn_enemies()


func _set_level(new_level: int) -> void:
	if spiral_weapon == null:
		return
	# Directly set level and refresh stats (bypasses normal upgrade flow)
	spiral_weapon.level = new_level
	spiral_weapon._apply_level_stats()
	print("\n--- Level set to %d ---" % new_level)
	_print_current_stats()


func _print_current_stats() -> void:
	if spiral_weapon == null:
		return
	print("Damage: %d | Feathers: %d | Radius: %.1fpx | Speed: %.2f rad/s" % [
		spiral_weapon.damage,
		spiral_weapon.feather_count,
		spiral_weapon.orbit_radius,
		spiral_weapon.orbit_speed,
	])


func _respawn_enemies() -> void:
	for enemy in spawned_enemies:
		if is_instance_valid(enemy):
			enemy.queue_free()
	spawned_enemies.clear()
	_spawn_test_enemies()
	print("[TEST] Enemies respawned!")


func _process(_delta: float) -> void:
	if spiral_weapon:
		var diff = spiral_weapon.global_position - player.global_position
		if diff.length() > 1.0:
			print("OFFSET: weapon=", spiral_weapon.global_position, " player=", player.global_position, " diff=", diff)
