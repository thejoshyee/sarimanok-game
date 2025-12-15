extends Node

# grid config
@export var cell_size: int = 64
@export var world_bounds: Rect2 = Rect2(0, 0, 1920, 1088)

# debug stats
var query_count: int = 0
var grid_update_count: int = 0

# grid storage: cell_id -> array of enemies in that cell
var _grid: Dictionary = {}

func _ready():
    pass

func _process(_delta: float) -> void:
    reset_stats()

# convert world position to unique cell ID
# uses a simple hash: (x << 16) | y where x and y are cell coordinates
func get_cell_id(position: Vector2) -> int:
    var cell_x = int(floor(position.x / cell_size))
    var cell_y = int(floor(position.y / cell_size))
    # combine x and y into a single integer id
    return (cell_x << 16) | (cell_y & 0xFFFF)


# add an enemy to the grid at its current position
func register_enemy(enemy: Node2D) -> void:
    var cell_id = get_cell_id(enemy.global_position)
    if not _grid.has(cell_id):
        _grid[cell_id] = []
    _grid[cell_id].append(enemy)

# remove an enemy from a specific cell
func unregister_enemy(enemy: Node2D, cell_id: int) -> void:
    if _grid.has(cell_id):
        _grid[cell_id].erase(enemy)
        if _grid[cell_id].is_empty():
            _grid.erase(cell_id)


func move_enemy(enemy: Node2D, old_cell_id: int, new_cell_id: int) -> void:
    unregister_enemy(enemy, old_cell_id)
    if not _grid.has(new_cell_id):
        _grid[new_cell_id] = []
    _grid[new_cell_id].append(enemy)
    grid_update_count += 1


# Retreieve all enemies in a specific cell
func get_cell(cell_id: int) -> Array:
    if _grid.has(cell_id):
        return _grid[cell_id]
    return []


# retrieve all enemies near a position (checks center cell + 8 neighbors)
func get_nearby_enemies(pos: Vector2, _radius: float = 128.0) -> Array:
    query_count += 1
    var enemies: Array = []
    var seen = {} # track enemies we've already added to avoid duplicates
    
    # get center cell coordinates
    var center_x = int(floor(pos.x / cell_size))
    var center_y = int(floor(pos.y / cell_size))

    # check 3x3 grid (center + 8 neighbors)
    for x_offset in [-1, 0, 1]:
        for y_offset in [-1, 0, 1]:
            var cell_x = center_x + x_offset
            var cell_y = center_y + y_offset
            var cell_id = (cell_x << 16) | (cell_y & 0xFFFF)

            var cell_enemies = get_cell(cell_id)
            for enemy in cell_enemies:
                if not seen.has(enemy):
                    enemies.append(enemy)
                    seen[enemy] = true
    return enemies


# reset debug stats (called each frame)
func reset_stats() -> void:
    query_count = 0
    grid_update_count = 0

# get current frame stats
func get_stats() -> Dictionary:
    var total_cells_used = _grid.size()
    var total_enemies = 0
    for enemies in _grid.values():
        total_enemies += enemies.size()

    var avg_enemies_per_active_cell = 0.0
    if total_cells_used > 0:
        avg_enemies_per_active_cell = float(total_enemies) / float(total_cells_used)
    
    return {
        "total_cells_used": total_cells_used,
        "avg_enemies_per_active_cell": avg_enemies_per_active_cell,
        "grid_update_count": grid_update_count,
        "query_count": query_count
    }
