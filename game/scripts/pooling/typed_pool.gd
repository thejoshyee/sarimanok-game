# Manages a pool of one specific type of object (e.g. all duwendes)
class_name TypedPool
extends RefCounted

var config: PoolConfig
var _scene: PackedScene
var _available: Array[Node] = [] # Objects ready to use
var _active: Array[Node] = [] # Objects in use in game
var _container: Node # parent node for pooled objects

func _init(pool_config: PoolConfig, container: Node) -> void:
	config = pool_config
	_container = container
	_scene = load(config.scene_path)

# pre-create objects at game start
func warm_up() -> void:
	for i in config.initial_size:
		var instance = _create_instance()
		_available.append(instance)

# get an object from the pool
func acquire(pos: Vector2 = Vector2.ZERO) -> Node:
	var instance: Node

	if _available.size() > 0:
		# reuse existing object
		instance = _available.pop_back()
	elif config.can_grow and (config.max_size == 0 or _active.size() < config.max_size):
		# pool empty but allowed to grow - create new
		instance = _create_instance()
	else:
		# pool exhausted
		push_warning("Pool exhausted for %s" % config.pool_id)
		return null

	_active.append(instance)
	instance.position = pos

	# call lifecycle methods if they exist
	if instance.has_method("reset_state"):
		instance.reset_state()
	if instance.has_method("on_spawn"):
		instance.on_spawn()

	return instance

# Return an object to the pool
func release(instance: Node) -> void:
	if not _active.has(instance):
		push_warning("Tried to release object not in active pool")
		return

	_active.erase(instance)
	_available.append(instance)

	# call lifecycle methods if they exist
	if instance.has_method("on_despawn"):
		instance.on_despawn()

# create new pooled instance (hidden by default)
func _create_instance() -> Node:
	var instance = _scene.instantiate()
	_container.add_child(instance)

	# start hidden / disabled
	if instance.has_method("on_despawn"):
		instance.on_despawn()
	else:
		instance.visible = false

	return instance

# stats for debugging
func get_stats() -> Dictionary:
	return {
		"pool_id": config.pool_id,
		"available": _available.size(),
		"active": _active.size(),
		"total": _available.size() + _active.size(),
		"max": config.max_size
	}
	
