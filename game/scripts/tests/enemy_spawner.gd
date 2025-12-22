extends Node2D


func spawn_enemies():
	var enemy_count = 100
	var spacing = 80
	var grid_size = int(ceil(sqrt(enemy_count)))

	for i in range(enemy_count):
		var enemy = PoolManager.spawn("enemy_test")
		if enemy:
			var row = int(i / grid_size)
			var col = i % grid_size
			enemy.position = Vector2(col * spacing + 100, row * spacing + 100)


func _process(_delta):
	# Check current active enemy count
	var active_count = get_tree().get_nodes_in_group('enemies').size()
	
	# Spawn more if below target
	if active_count < 100:
		var to_spawn = 100 - active_count
		for i in range(to_spawn):
			var enemy = PoolManager.spawn("enemy_test")
			if enemy:
				# Spawn at random position around center
				var angle = randf() * TAU
				var distance = randf_range(200, 400)
				enemy.position = Vector2(320, 180) + Vector2(cos(angle), sin(angle)) * distance
