extends Node2D

func _draw() -> void:
	# Draw dark gray background
	draw_rect(Rect2(-400, -400, 800, 800), Color(0.2, 0.2, 0.2, 1), true)

func _ready() -> void:
	queue_redraw()
