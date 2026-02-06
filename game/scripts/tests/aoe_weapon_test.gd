extends Node2D

# === REFERENCES ===
# We'll get the player node from the scene tree (we'll add it to the scene later)
@onready var player: CharacterBody2D = $SarimanokPlayer
# WeaponManager is a child of Player (already set up in player.tscn)
@onready var weapon_manager: WeaponManager = $SarimanokPlayer/WeaponManager

# === WEAPON DATA ===
# Preload the .tres resources so we can add weapons at runtime
var wing_slap_data: WeaponData = preload("res://weapons/data/wing_slap.tres")
var flame_wing_data: WeaponData = preload("res://weapons/data/flame_wing.tres")

# === TEST ENEMY SCENE ===
# We'll spawn these at known distances to test AOE radius
var test_enemy_scene: PackedScene = preload("res://scenes/enemies/test_enemy.tscn")

# Track spawned enemies so we can clean them up and respawn
var spawned_enemies: Array = []

func _ready() -> void:
	# Add both AOE weapons to the player's WeaponManager
	# add_weapon() handles instantiation and slotting automatically
	weapon_manager.add_weapon(wing_slap_data)
	weapon_manager.add_weapon(flame_wing_data)
	print("[TEST] Added Wing Slap and Flame Wing weapons")
	
	# Spawn enemies at known distances so we can verify AOE radius
	_spawn_test_enemies()
	
	# Print controls so we know what keys do what
	print("[TEST] Controls:")
	print("  1 = Upgrade Wing Slap")
	print("  2 = Upgrade Flame Wing")
	print("  R = Respawn enemies")

	# Make weapon visuals semi-transparent so we can see enemies through them
	for slot_index in range(weapon_manager.MAX_WEAPONS):
		var weapon = weapon_manager.weapon_slots[slot_index]
		if weapon and weapon is AOECircleWeapon:
			weapon.placeholder.modulate.a = 0.3



func _spawn_test_enemies() -> void:
	# Distances chosen to test AOE boundaries clearly:
	# 40px = inside both weapons (Flame Wing 48, Wing Slap 64)
	# 70px = inside Wing Slap only (edge at 54 < 64, but > 48)
	# 100px = outside both (edge at 84 > 64)
	var distances := [40.0, 70.0, 100.0]
	var directions := [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	
	for dist in distances:
		for dir in directions:
			var enemy = test_enemy_scene.instantiate()
			enemy.position = player.position + (dir * dist)
			enemy.speed = 0.0
			# High HP so enemies survive multiple hits -- lets us observe the pattern
			enemy.base_max_hp = 999
			enemy.hp = 999
			add_child(enemy)
			enemy.on_spawn()
			spawned_enemies.append(enemy)
	
	print("[TEST] Spawned %d enemies at distances 40/70/100px" % spawned_enemies.size())



# _unhandled_input fires for any key NOT consumed by the UI system
# _unhandled_input instead of _input: avoids conflicts if UI elements exist
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1:
				# Upgrade Wing Slap through levels 1→2→3→4→5
				weapon_manager.upgrade_weapon("wing_slap")
				var w = weapon_manager.get_weapon_by_id("wing_slap")
				if w:
					print("[TEST] Wing Slap upgraded to level %d (dmg: %d)" % [w.level, w.damage])
			KEY_2:
				# Upgrade Flame Wing through levels 1→2→3→4→5
				weapon_manager.upgrade_weapon("flame_wing")
				var w = weapon_manager.get_weapon_by_id("flame_wing")
				if w:
					print("[TEST] Flame Wing upgraded to level %d (dmg: %d)" % [w.level, w.damage])
			KEY_R:
				# Clear dead/existing enemies and spawn fresh ones
				_respawn_enemies()


func _respawn_enemies() -> void:
	# Remove all existing test enemies from the scene
	for enemy in spawned_enemies:
		if is_instance_valid(enemy):
			enemy.queue_free()
	spawned_enemies.clear()
	
	# Spawn fresh enemies at the same distances
	_spawn_test_enemies()
	print("[TEST] Enemies respawned!")
