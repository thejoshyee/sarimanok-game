extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Start hidden - only show when paused
	visible = false
	
	# Connect button signals
	$VBoxContainer/Resume.pressed.connect(_on_resume_pressed)
	$VBoxContainer/Quit.pressed.connect(_on_quit_pressed)

func _input(event: InputEvent) -> void:
	# Listen for pause action (esc key or start button)
	if event.is_action_pressed("pause"):
		_toggle_pause()
		get_viewport().set_input_as_handled() # prevent ui_cancel from also triggering
		return

	# also allow ui_cancel to close the menu when paused
	if event.is_action_pressed("ui_cancel") and get_tree().paused:
		_toggle_pause()
		get_viewport().set_input_as_handled()

func _toggle_pause() -> void:
	# Flip the pause state
	get_tree().paused = !get_tree().paused
	# show menu when paused, hide when unpaused
	visible = get_tree().paused

	# Focus the Resume button when menu opens
	if visible:
		$VBoxContainer/Resume.grab_focus()

func _on_resume_pressed() -> void:
	_toggle_pause()

func _on_quit_pressed() -> void:
	# unpause first then quit
	get_tree().paused = false
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
