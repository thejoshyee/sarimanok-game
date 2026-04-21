extends Label

## Floating damage number that tweens up and fades, then returns to pool.
# Tween config — tweak in Inspector if feel is off
@export var rise_distance: float = 20.0    # pixels to float upward
@export var lifetime: float = 0.6           # total animation time (seconds)

var _tween: Tween


# Called by whoever spawns the label (e.g. enemy.take_damage())
func show_damage(amount: int) -> void:
	text = str(amount)
	modulate.a = 1.0  # reset alpha (pool may have faded previous use)

	# Kill any leftover tween from a reused pool instance
	if _tween and _tween.is_valid():
		_tween.kill()

	_tween = create_tween().set_parallel(true)  # rise and fade run together
	_tween.tween_property(self, "position:y", position.y - rise_distance, lifetime)
	_tween.tween_property(self, "modulate:a", 0.0, lifetime)
	# When finished, return to pool instead of queue_free
	_tween.chain().tween_callback(_return_to_pool)


func _return_to_pool() -> void:
	PoolManager.despawn(self)


# === POOLING LIFECYCLE ===

func on_spawn() -> void:
	visible = true


func on_despawn() -> void:
	visible = false
	if _tween and _tween.is_valid():
		_tween.kill()


func reset_state() -> void:
	modulate.a = 1.0
	# position.y is reset when acquire() sets position, no need here
