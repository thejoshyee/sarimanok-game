extends Control

@onready var vbox = $CanvasLayer/Panel/VBoxContainer
@onready var title_label = $CanvasLayer/Panel/VBoxContainer/TitleLabel

var _pool_labels: Dictionary = {}  # { "pool_id": Label }

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title_label.text = "Pool Debug Monitor"
	
	# Update stats every 0.5 seconds
	var timer = Timer.new()
	timer.wait_time = 0.5
	timer.timeout.connect(_update_stats)
	add_child(timer)
	timer.start()

func _update_stats() -> void:
	var all_stats = PoolManager.get_all_stats()
	
	for pool_id in all_stats.keys():
		var stats = all_stats[pool_id]
		var label: Label 

		# Create label if this is a new pool
		if not _pool_labels.has(pool_id):
			label = Label.new()
			vbox.add_child(label)
			_pool_labels[pool_id] = label
		else:
			label = _pool_labels[pool_id]
		
		# Update the label text with current stats
		label.text = "%s: %d/%d active (max: %d)" % [
			pool_id, 
			stats.active, 
			stats.total,
			stats.max if stats.max > 0 else 999
		]

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_F3:
		$CanvasLayer.visible = not $CanvasLayer.visible