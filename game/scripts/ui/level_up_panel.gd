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


	# --- Pixel font theme setup ---
	var font = load("res://assets/fonts/m5x7.ttf")

	# Panel background style
	var panel_style = StyleBoxFlat.new()
	panel_style.bg_color = Color(0.1, 0.08, 0.15, 0.95)  # Dark purple, nearly opaque
	panel_style.border_color = Color(0.9, 0.75, 0.3)       # Gold border (Sarimanok colors)
	panel_style.set_border_width_all(2)
	panel_style.set_corner_radius_all(2)
	panel_style.set_content_margin_all(8)
	$PanelContainer.add_theme_stylebox_override("panel", panel_style)

	# Apply pixel font to labels with size hierarchy: title > buttons > hint
	$PanelContainer/VBoxContainer/LevelUpLabel.add_theme_font_override("font", font)
	$PanelContainer/VBoxContainer/LevelUpLabel.add_theme_font_size_override("font_size", 32)
	$PanelContainer/VBoxContainer/ClickToChooseLabel.add_theme_font_override("font", font)
	$PanelContainer/VBoxContainer/ClickToChooseLabel.add_theme_font_size_override("font_size", 16)

	# Title gets gold color
	$PanelContainer/VBoxContainer/LevelUpLabel.add_theme_color_override("font_color", Color(0.9, 0.75, 0.3))

	# Button styles
	var btn_normal = StyleBoxFlat.new()
	btn_normal.bg_color = Color(0.15, 0.12, 0.2)
	btn_normal.border_color = Color(0.4, 0.35, 0.5)
	btn_normal.set_border_width_all(1)
	btn_normal.set_corner_radius_all(2)
	btn_normal.set_content_margin_all(3)

	var btn_hover = btn_normal.duplicate()
	btn_hover.bg_color = Color(0.25, 0.2, 0.35)
	btn_hover.border_color = Color(0.9, 0.75, 0.3)  # Gold highlight on hover

	var btn_focus = btn_hover.duplicate()  # Same as hover for keyboard nav

	var btn_pressed = btn_normal.duplicate()
	btn_pressed.bg_color = Color(0.35, 0.28, 0.45)

	for btn in [$PanelContainer/VBoxContainer/HBoxContainer/UpgradeOption1,
				$PanelContainer/VBoxContainer/HBoxContainer/UpgradeOption2,
				$PanelContainer/VBoxContainer/HBoxContainer/UpgradeOption3]:
		btn.add_theme_font_override("font", font)
		btn.add_theme_font_size_override("font_size", 24)
		btn.add_theme_color_override("font_color", Color.WHITE)
		btn.add_theme_color_override("font_hover_color", Color(0.9, 0.75, 0.3))
		btn.alignment = HORIZONTAL_ALIGNMENT_LEFT
		btn.add_theme_stylebox_override("normal", btn_normal)
		btn.add_theme_stylebox_override("hover", btn_hover)
		btn.add_theme_stylebox_override("focus", btn_focus)
		btn.add_theme_stylebox_override("pressed", btn_pressed)


# Create a 16x16 solid-color placeholder icon texture
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
			# Show "NEW: Weapon Name" or "UP: Weapon Name Lv X→Y"
			if choice.type == "new":
				buttons[i].text = "NEW: " + choice.weapon_data.display_name
			else:
				var current_lvl = weapon_manager.get_weapon_by_id(choice.weapon_data.id).level
				buttons[i].text = "UP: " + choice.weapon_data.display_name + " Lv" + str(current_lvl) + " > " + str(current_lvl + 1) + " "
			buttons[i].icon = _make_icon(icon_colors[i])
			buttons[i].visible = true
		else:
			# Hide button if fewer than 3 choices available
			buttons[i].visible = false
	
	# Pause the game and show the panel
	get_tree().paused = true
	visible = true
	
	# Focus first visible button
	if current_choices.size() > 0:
		buttons[0].grab_focus()


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
