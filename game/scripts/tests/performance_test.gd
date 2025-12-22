extends Node2D

# Reference to the enemy pool config
@export var enemy_pool_config: PoolConfig

func _ready() -> void:
	# Register and warm up the enemy pool before spawning
	if enemy_pool_config:
		PoolManager.register_pool(enemy_pool_config)
		PoolManager.preload_all()
		print("Enemy pool ready: ", PoolManager.get_pool_stats("enemy_test"))
