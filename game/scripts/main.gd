extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Print viewport size to confirm 640×360
	var viewport_size = get_viewport().get_visible_rect().size
	print("Viewport size: ", viewport_size)
	
	# Print camera position for debugging
	print("Camera position: ", $Camera2D.position)

	queue_redraw()

	# Enable camera smoothing for testing
	$Camera2D.position_smoothing_enabled = true
	$Camera2D.position_smoothing_speed = 5.0


func _draw():
	# Draw tile grid overlay (32×32 tiles)
	var grid_color = Color(1, 1, 0, 0.3)  # Yellow, semi-transparent
	
	# Draw vertical lines every 32 pixels
	for x in range(0, 1920 + 32, 32):
		draw_line(Vector2(x, 0), Vector2(x, 1088), grid_color, 1)
	
	# Draw horizontal lines every 32 pixels
	for y in range(0, 1088 + 32, 32):
		draw_line(Vector2(0, y), Vector2(1920, y), grid_color, 1)
	
	# Draw arena boundary in red
	draw_rect(Rect2(0, 0, 1920, 1088), Color.RED, false, 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Move camera with arrow keys for testing
	var move_speed = 300 * delta
	if Input.is_action_pressed("ui_right"):
		$Camera2D.position.x += move_speed
	if Input.is_action_pressed("ui_left"):
		$Camera2D.position.x -= move_speed
	if Input.is_action_pressed("ui_down"):
		$Camera2D.position.y += move_speed
	if Input.is_action_pressed("ui_up"):
		$Camera2D.position.y -= move_speed
