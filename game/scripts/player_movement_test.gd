extends Node2D

func _draw() -> void:
	draw_rect(Rect2(-400, -400, 800, 800), Color(0.2, 0.2, 0.2, 1), true)

	# draw 100px grid to measure movement visually
	var grid_color = Color(0.5, 0.5, 0.5, 1)  # Lighter gray for contrast

	# draw vertical lines every 100px
	for x in range(-400, 401, 100):
		draw_line(Vector2(x, -400), Vector2(x, 400), grid_color, 2)

	# draw horizontal lines every 100px
	for y in range(-400, 401, 100):
		draw_line(Vector2(-400, y), Vector2(400, y), grid_color, 2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()
