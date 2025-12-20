extends CanvasLayer

signal upgrade_selected(upgrade_type: String, level: int)

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var progression: Progression = ProgressionManager

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
	# apply the upgrade  based on option selected
	match option_number:
		1: # Increase Move Speed
			player.stats.move_speed *= 1.1
			print("Applied +10% Move Speed at level ", progression.current_level, 
			" (New speed: ", player.stats.move_speed, ")")

		2: # Increase Max HP
			player.stats.max_hp += 10
			player.current_hp += 10 # Also heal the player by 10
			print("Applied +10 Max HP at level ", progression.current_level,
			" (New max HP: ", player.stats.max_hp, ")")

		3: # Increase Damage +1
			player.stats.damage_multiplier += 0.1 # +10% damage = +0.1 multiplier
			print("Applied +10% Weapon Damage at level ", progression.current_level, 
			" (New damage: ", player.stats.damage_multiplier, ")")

	# Emit signal for future weapon/passive system integration
	var upgrade_names = ["move_speed", "max_hp", "damage"]
	upgrade_selected.emit(upgrade_names[option_number - 1], progression.current_level)
			
	# Hide panel and unpause the game
	visible = false
	get_tree().paused = false
