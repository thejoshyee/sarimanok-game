# Central manage for all object pools - use this from anywhere in the game
extends Node

# All our pools, organized by ID
var _pools: Dictionary = {}  # { "enemy_duwende": TypedPool, "projectile_feather": TypedPool, ... }

# container nodes for each category (keeps scene tree organized)
var _enemy_container: Node
var _projectile_container: Node
var _pickup_container: Node
var _particle_container: Node


func _ready() -> void:
	# create container nodes to keep the scene tree organized
	_enemy_container = Node.new()
	_enemy_container.name = "Enemies"
	add_child(_enemy_container)

	_projectile_container = Node.new()
	_projectile_container.name = "Projectiles"
	add_child(_projectile_container)

	_pickup_container = Node.new()
	_pickup_container.name = "Pickups"
	add_child(_pickup_container)

	_particle_container = Node.new()
	_particle_container.name = "Particles"
	add_child(_particle_container)


# register a new pool with a config
func register_pool(config: PoolConfig) -> void:
	# figure out which container this pool should use 
	var container: Node
	if config.pool_id.begins_with("enemy_"):
		container = _enemy_container
	elif config.pool_id.begins_with("projectile_"):
		container = _projectile_container
	elif config.pool_id.begins_with("pickup_"):
		container = _pickup_container
	elif config.pool_id.begins_with("particle_"):
		container = _particle_container
	else:
		push_warning("Unknown pool ID: %s" % config.pool_id)
		return

	# create the Typedpool and store it in the dictionary
	var pool = TypedPool.new(config, container)
	_pools[config.pool_id] = pool


# spawn an object from a pool
func spawn(pool_id: String, pos: Vector2 = Vector2.ZERO) -> Node:
	if not _pools.has(pool_id):
		push_error("Pool not found: %s" % pool_id)
		return null

	var pool = _pools[pool_id]
	return pool.acquire(pos)


# return an object to its pool
func despawn(node: Node) -> void:
	# find which pool this node belongs to
	for pool in _pools.values():
		if pool._active.has(node):
			pool.release(node)
			return

	push_warning("Object not found in any pool: %s" % node.name)


# warm up all registered pools
func preload_all() -> void:
	for pool in _pools.values():
		pool.warm_up()
	print("All pools warmed up")


# gets stats for a specific pool
func get_pool_stats(pool_id: String) -> Dictionary:
	if not _pools.has(pool_id):
		push_error("Pool not found: %s" % pool_id)
		return {}

	return _pools[pool_id].get_stats()


# gets stats for all pools
func get_all_stats() -> Dictionary:
	var all_stats: Dictionary = {}
	for pool_id in _pools.keys():
		all_stats[pool_id] = _pools[pool_id].get_stats()
	return all_stats
