extends CanvasLayer

signal upgrade_selected(upgrade_type: String, level: int)

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var progression: Progression = ProgressionManager

var weapon_manager: Node = null

# Store the current choices so _on_option_selected can use them
var current_choices: Array = []

func _ready() -> void:
	# Start hidden - only show when level-up occurs
	visible = false
	
	# Connect button signals
	$PanelContainer/VBoxContainer/HBoxContainer/UpgradeOption1.pressed.connect(_on_option_selected.bind(1))
	$PanelContainer/VBoxContainer/HBoxContainer/UpgradeOption2.pressed.connect(_on_option_selected.bind(2))
	$PanelContainer/VBoxContainer/HBoxContainer/UpgradeOption3.pressed.connect(_on_option_selected.bind(3))


# Placeholder: generates a solid-color 16x16 square icon.
# Replace with real weapon art textures when available
func _make_icon(color: Color) -> ImageTexture:
	var img = Image.create(16, 16, false, Image.FORMAT_RGBA8)
	img.fill(color)
	return ImageTexture.create_from_image(img)


func show_level_up(_new_level: int) -> void:
	# Generate dynamic weapon choices from WeaponDatabase
	current_choices = WeaponDatabase.get_level_up_choices(weapon_manager)
	
	# Update button labels to show weapon choices
	var buttons = [
		$PanelContainer/VBoxContainer/HBoxContainer/UpgradeOption1,
		$PanelContainer/VBoxContainer/HBoxContainer/UpgradeOption2,
		$PanelContainer/VBoxContainer/HBoxContainer/UpgradeOption3
	]

	# Distinct colors per slot so you can tell icons apart visually
	var icon_colors = [Color.TOMATO, Color.MEDIUM_SEA_GREEN, Color.CORNFLOWER_BLUE]


	for i in range(3):
		if i < current_choices.size():
			var choice = current_choices[i]
			# Show "Weapon Name  NEW" or "Weapon Name  +1  Lv.X→Y"
			if choice.type == "new":
				buttons[i].text = "NEW!\n" + choice.weapon_data.display_name
				buttons[i].add_theme_color_override("font_color", Color(0.9, 0.75, 0.3))
				var tween = create_tween().set_loops()
				tween.tween_property(buttons[i], "modulate:a", 0.4, 0.5)
				tween.tween_property(buttons[i], "modulate:a", 1.0, 0.5)
			else:
				buttons[i].remove_theme_color_override("font_color")
				buttons[i].modulate.a = 1.0
				var current_lvl = weapon_manager.get_weapon_by_id(choice.weapon_data.id).level
				buttons[i].text = choice.weapon_data.display_name + " +1 Lv." + str(current_lvl) + " > " + str(current_lvl + 1) + " "


			buttons[i].icon = _make_icon(icon_colors[i])
			buttons[i].visible = true
		else:
			# Hide button if fewer than 3 choices available
			buttons[i].visible = false

	# Set focus neighbors so arrow keys wrap around the visible buttons
	var visible_buttons: Array[Button] = []
	for btn in buttons:
		if btn.visible:
			visible_buttons.append(btn)
	
	for i in range(visible_buttons.size()):
		var prev = visible_buttons[(i - 1) % visible_buttons.size()]
		var next = visible_buttons[(i + 1) % visible_buttons.size()]
		visible_buttons[i].focus_neighbor_left = prev.get_path()
		visible_buttons[i].focus_neighbor_right = next.get_path()
		# Also handle up/down as aliases for left/right since buttons are horizontal
		visible_buttons[i].focus_neighbor_top = prev.get_path()
		visible_buttons[i].focus_neighbor_bottom = next.get_path()
		
	
	# Pause the game and show the panel
	get_tree().paused = true
	visible = true
	
	# Focus first visible button
	if visible_buttons.size() > 0:
		visible_buttons[0].grab_focus()



func _on_option_selected(option_number: int) -> void:
	# option_number is 1-based, array is 0-based
	var index = option_number - 1
	if index >= current_choices.size():
		return
	
	var choice = current_choices[index]
	
	if choice.type == "new":
		# Add new weapon to player's arsenal
		weapon_manager.add_weapon(choice.weapon_data)
		print("Added new weapon: ", choice.weapon_data.display_name)
	else:
		# Upgrade existing weapon
		weapon_manager.upgrade_weapon(choice.weapon_data.id)
		print("Upgraded weapon: ", choice.weapon_data.display_name)
	
	# Emit signal for any listeners
	upgrade_selected.emit(choice.type, progression.current_level)
	
	# Hide panel and unpause
	visible = false
	get_tree().paused = false
