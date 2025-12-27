extends Node2D

func _ready():
	# Register the test enemy pool
	var config = preload("res://resources/test_enemy_pool.tres")
	PoolManager.register_pool(config)
	
	# Warm up the pool (pre-create 10 enemies)
	PoolManager.preload_all()
	
	# Spawn 3 test enemies
	for i in 3:
		var enemy = PoolManager.spawn("enemy_test", Vector2(100 + i * 100, 200))
		print("Spawned enemy at: ", enemy.position)
	
	# Print pool stats
	print(PoolManager.get_pool_stats("enemy_test"))
