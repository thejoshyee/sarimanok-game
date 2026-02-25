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
	$VBoxContainer/UpgradeOption1.pressed.connect(_on_option_selected.bind(1))
	$VBoxContainer/UpgradeOption2.pressed.connect(_on_option_selected.bind(2))
	$VBoxContainer/UpgradeOption3.pressed.connect(_on_option_selected.bind(3))


func show_level_up(_new_level: int) -> void:
	# Generate dynamic weapon choices from WeaponDatabase
	current_choices = WeaponDatabase.get_level_up_choices(weapon_manager)
	
	# Update button labels to show weapon choices
	var buttons = [
		$VBoxContainer/UpgradeOption1,
		$VBoxContainer/UpgradeOption2,
		$VBoxContainer/UpgradeOption3
	]
	
	for i in range(3):
		if i < current_choices.size():
			var choice = current_choices[i]
			# Show "NEW: Weapon Name" or "UP: Weapon Name Lv X→Y"
			if choice.type == "new":
				buttons[i].text = "NEW: " + choice.weapon_data.display_name
			else:
				var current_lvl = weapon_manager.get_weapon_by_id(choice.weapon_data.id).level
				buttons[i].text = "UP: " + choice.weapon_data.display_name + " Lv" + str(current_lvl) + "→" + str(current_lvl + 1)
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
