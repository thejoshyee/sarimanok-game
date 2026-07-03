extends Node

@export var canvas_modulate_path: NodePath

@onready var canvas_modulate: CanvasModulate = get_node(canvas_modulate_path)

@export var dawn_color: Color = Color(1.0, 0.95, 0.9)

var _transition_started: bool = false

func _ready() -> void:
	GameTimer.run_won.connect(_on_run_won)

func _on_run_won() -> void:
	if _transition_started:
		return
	_transition_started = true
	create_tween().tween_property(canvas_modulate, "color", dawn_color, 2.0)
