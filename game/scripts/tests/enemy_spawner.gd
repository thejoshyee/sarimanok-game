extends Node2D

const TestEnemy = preload("res://scenes/tests/test_enemy.tscn")

func _ready():
	spawn_enemies()

func spawn_enemies():
	var enemy_count = 100
	var spacing = 80
	var grid_size = int(ceil(sqrt(enemy_count)))

	for i in range(enemy_count):
		var enemy = TestEnemy.instantiate()
		var row = int(i / grid_size)
		var col = i % grid_size
		enemy.position = Vector2(col * spacing + 100, row * spacing + 100)
		add_child(enemy)
