extends Node

@export var canvas_modulate_path: NodePath

@onready var canvas_modulate: CanvasModulate = get_node(canvas_modulate_path)

var _transition_started: bool = false

func _ready() -> void:
	GameTimer.run_won.connect(_on_run_won)

func _on_run_won() -> void:
	if _transition_started:
		return
	_transition_started = true
	print("DawnController: dawn transition triggered")
