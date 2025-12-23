extends CharacterBody2D

@export var speed: float = 50.0
var _current_cell_id: int = -1 # track which grid cell this enemy is in


func _ready():
	# Don't add to group here - on_spawn() handles it when active
	pass

func _physics_process(_delta: float) -> void:
	# Get reference to player and move toward them
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

		var new_cell_id = GridManager.get_cell_id(global_position)
		if new_cell_id != _current_cell_id and _current_cell_id != -1:
					GridManager.move_enemy(self, _current_cell_id, new_cell_id)
					_current_cell_id = new_cell_id


func reset_state() -> void:
	velocity = Vector2.ZERO


func on_spawn() -> void:
	visible = true
	set_physics_process(true)
	z_index = 10  # Pooled enemies need higher z_index to render above main scene
	add_to_group("enemies")  # Only in group when active
	# register with grid system
	GridManager.register_enemy(self)
	_current_cell_id = GridManager.get_cell_id(global_position)


func on_despawn() -> void:
	visible = false
	set_physics_process(false)
	remove_from_group("enemies") # remove when inactive
	# unregister from grid system
	if _current_cell_id != -1:
		GridManager.unregister_enemy(self, _current_cell_id)
		_current_cell_id = -1

func take_damage(_amount: float) -> void:
	# print("Enemy took ", amount, " damage")
	# Return to pool instead of freeing
	PoolManager.despawn(self)
