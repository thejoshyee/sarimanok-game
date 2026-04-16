extends CanvasLayer

signal upgrade_selected(upgrade_type: String, level: int)

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var progression: Progression = ProgressionManager
@onready var level_up_sfx: AudioStreamPlayer = $LevelUpSFX

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
	# Legacy path: generates choices itself (used by test scenes)
	current_choices = WeaponDatabase.get_level_up_choices(weapon_manager)
	_display_choices()


# Called by main.gd with pre-built choices from LevelUpManager
func show_level_up_with_choices(_new_level: int, choices: Array) -> void:
	current_choices = choices
	_display_choices()


func _display_choices() -> void:
	var buttons = [
		$PanelContainer/VBoxContainer/HBoxContainer/UpgradeOption1,
		$PanelContainer/VBoxContainer/HBoxContainer/UpgradeOption2,
		$PanelContainer/VBoxContainer/HBoxContainer/UpgradeOption3
	]

	var icon_colors = [Color.TOMATO, Color.MEDIUM_SEA_GREEN, Color.CORNFLOWER_BLUE]

	for i in range(3):
		if i < current_choices.size():
			var choice = current_choices[i]
			if choice.type == "new" or choice.type == "new_weapon":
				buttons[i].text = "NEW!\n" + choice.get("data", choice.get("weapon_data")).display_name
				buttons[i].add_theme_color_override("font_color", Color(0.9, 0.75, 0.3))
				var tween = create_tween().set_loops()
				tween.tween_property(buttons[i], "modulate:a", 0.4, 0.5)
				tween.tween_property(buttons[i], "modulate:a", 1.0, 0.5)
			elif choice.type == "upgrade_passive":
				buttons[i].remove_theme_color_override("font_color")
				buttons[i].modulate.a = 1.0
				var passive = choice.data
				var current_lvl = PassiveManager.get_level(passive.id)
				buttons[i].text = passive.display_name + " +1 Lv." + str(current_lvl) + " > " + str(current_lvl + 1)
			else:
				buttons[i].remove_theme_color_override("font_color")
				buttons[i].modulate.a = 1.0
				var weapon_data = choice.get("data", choice.get("weapon_data"))
				var current_lvl = weapon_manager.get_weapon_by_id(weapon_data.id).level
				buttons[i].text = weapon_data.display_name + " +1 Lv." + str(current_lvl) + " > " + str(current_lvl + 1)

			buttons[i].icon = _make_icon(icon_colors[i])
			buttons[i].visible = true
		else:
			buttons[i].visible = false

	var visible_buttons: Array[Button] = []
	for btn in buttons:
		if btn.visible:
			visible_buttons.append(btn)
	
	for i in range(visible_buttons.size()):
		var prev = visible_buttons[(i - 1) % visible_buttons.size()]
		var next = visible_buttons[(i + 1) % visible_buttons.size()]
		visible_buttons[i].focus_neighbor_left = prev.get_path()
		visible_buttons[i].focus_neighbor_right = next.get_path()
		visible_buttons[i].focus_neighbor_top = prev.get_path()
		visible_buttons[i].focus_neighbor_bottom = next.get_path()
	
	get_tree().paused = true
	visible = true
	level_up_sfx.play()  # panel is the single funnel for both show_level_up paths, so one trigger covers all level-up cases

	if visible_buttons.size() > 0:
		visible_buttons[0].grab_focus()


func _on_option_selected(option_number: int) -> void:
	var index = option_number - 1
	if index >= current_choices.size():
		return
	
	var choice = current_choices[index]
	var choice_type = choice.type
	
	if choice_type == "new" or choice_type == "new_weapon":
		var weapon_data = choice.get("data", choice.get("weapon_data"))
		weapon_manager.add_weapon(weapon_data)
		print("Added new weapon: ", weapon_data.display_name)
	elif choice_type == "upgrade" or choice_type == "upgrade_weapon":
		var weapon_data = choice.get("data", choice.get("weapon_data"))
		weapon_manager.upgrade_weapon(weapon_data.id)
		print("Upgraded weapon: ", weapon_data.display_name)
	elif choice_type == "upgrade_passive":
		PassiveManager.upgrade_passive(choice.data.id)
		print("Upgraded passive: ", choice.data.display_name)

	upgrade_selected.emit(choice_type, progression.current_level)
	
	visible = false
	get_tree().paused = false
