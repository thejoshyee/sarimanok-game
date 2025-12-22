extends Node2D


var attack_cooldown = 1.0
var current_cooldown = 0.0
var damage = 10


@onready var player = get_parent().get_node("Player")

func _process(delta: float) -> void:
	if current_cooldown > 0:
		current_cooldown -= delta
	else:
		fire_weapon()
		current_cooldown = attack_cooldown


func fire_weapon() -> void:
	# simple AOE attack - damage all enemies in range
	var enemies = get_tree().get_nodes_in_group('enemies')
	for enemy in enemies:
		if enemy.position.distance_to(player.position) < 100:
			enemy.take_damage(damage)
			
