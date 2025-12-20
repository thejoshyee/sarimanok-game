extends CanvasLayer


func _ready() -> void:
	# Start hidden - only show when level-up occurs
	visible = false
	
	# Connect button signals
	$VBoxContainer/UpgradeOption1.pressed.connect(_on_option_selected.bind(1))
	$VBoxContainer/UpgradeOption2.pressed.connect(_on_option_selected.bind(2))
	$VBoxContainer/UpgradeOption3.pressed.connect(_on_option_selected.bind(3))


func show_level_up(_new_level: int) -> void:
	# Pause the game and show the panel
	get_tree().paused = true
	visible = true

	# focus the first button for keyboard/controller navigation
	$VBoxContainer/UpgradeOption1.grab_focus()


func _on_option_selected(option_number: int) -> void:
	# Log which option was selected (placeholder for now)
	print("Player selected upgrade option: ", option_number)

	# Hide panel and unpause the game
	visible = false
	get_tree().paused = false
