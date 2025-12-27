extends Node2D

@onready var grid_manager = GridManager
var debug_enabled: bool = false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("grid_debug"):
		debug_enabled = !debug_enabled
		queue_redraw()

	if debug_enabled:
		queue_redraw()

func _draw() -> void:
	if not debug_enabled:
		return
	# Draw grid cells with color coding
	for cell_id in grid_manager._grid.keys():
		var enemies_in_cell = grid_manager._grid[cell_id]
		var cell_count = enemies_in_cell.size()
		
		# Decode cell_id back to x, y coordinates
		var cell_x = cell_id >> 16
		var cell_y = cell_id & 0xFFFF
		var world_x = cell_x * grid_manager.cell_size
		var world_y = cell_y * grid_manager.cell_size
		
		# Choose color based on enemy count
		var color: Color
		if cell_count == 0:
			color = Color.GREEN
		elif cell_count <= 5:
			color = Color.YELLOW
		else:
			color = Color.RED
		
		# Draw rectangle for this cell
		var rect = Rect2(world_x, world_y, grid_manager.cell_size, grid_manager.cell_size)
		draw_rect(rect, color, false, 1.0)


	# Draw stats text
	var stats = grid_manager.get_stats()
	var y_offset = 20
	var text_color = Color.WHITE
	
	draw_string(ThemeDB.fallback_font, Vector2(10, y_offset), 
		"Grid Stats (Press F3 to toggle)", HORIZONTAL_ALIGNMENT_LEFT, -1, 16, text_color)
	y_offset += 25
	
	draw_string(ThemeDB.fallback_font, Vector2(10, y_offset), 
		"Cells Used: %d" % stats["total_cells_used"], HORIZONTAL_ALIGNMENT_LEFT, -1, 16, text_color)
	y_offset += 20
	
	draw_string(ThemeDB.fallback_font, Vector2(10, y_offset), 
		"Avg Enemies/Cell: %.2f" % stats["avg_enemies_per_active_cell"], HORIZONTAL_ALIGNMENT_LEFT, -1, 16, text_color)
	y_offset += 20
	
	draw_string(ThemeDB.fallback_font, Vector2(10, y_offset), 
		"Grid Updates: %d" % stats["grid_update_count"], HORIZONTAL_ALIGNMENT_LEFT, -1, 16, text_color)
	y_offset += 20
	
	draw_string(ThemeDB.fallback_font, Vector2(10, y_offset), 
		"Queries: %d" % stats["query_count"], HORIZONTAL_ALIGNMENT_LEFT, -1, 16, text_color)
