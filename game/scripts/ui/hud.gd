extends CanvasLayer

signal level_up_bar_complete(new_level: int)

@onready var hp_label: Label = $MarginContainer/VBoxContainer/HPLabel
@onready var cooldown_label: Label = $MarginContainer/VBoxContainer/CooldownLabel
@onready var stats_label: Label = $MarginContainer/VBoxContainer/StatsLabel
@onready var xp_bar: ProgressBar = $XPBar

# Tracks whether we're mid-level-up animation
var _leveling_up := false
var _old_max_value: float = 0.0

var _pending_xp: int = 0
var _pending_xp_needed: int = 0


func _ready() -> void:
	# find the player and connect to it
	var player = get_tree().get_first_node_in_group("player")
	if player:
		update_hp(player.current_hp, player.stats.max_hp)

	# Connect to XP signal — "ring the bell, HUD listens"
	ProgressionManager.xp_changed.connect(_on_xp_changed)

	# Also listen for level-ups so we can do the "fill to full" animation
	ProgressionManager.level_up.connect(_on_level_up)

	# Set initial bar state
	xp_bar.max_value = ProgressionManager.get_xp_for_level(ProgressionManager.current_level)
	xp_bar.value = ProgressionManager.current_xp


func _process(_delta: float) -> void:
	# update HP display every frame
	var player = get_tree().get_first_node_in_group("player")
	if player:
		update_hp(player.current_hp, player.stats.max_hp)
		update_weapon_stats(player)

func update_hp(current: float, max_hp: float) -> void:
	hp_label.text = "HP: %d/%d" % [current, max_hp]

func update_weapon_stats(player: CharacterBody2D) -> void:
	# Display weapon cooldown for slot 0
	var weapon_manager = player.get_node("WeaponManager")
	var cooldown = weapon_manager.get_cooldown(0)
	cooldown_label.text = "Weapon Cooldown: %.2fs" % [cooldown]

	# display player stats
	var stats = player.stats
	stats_label.text = "Damage: %.1fx | Attack Speed: %.1fx" % [stats.damage_multiplier, stats.attack_speed_multiplier]


func _on_xp_changed(current_xp: int, xp_needed: int) -> void:
	if _leveling_up:
		# Just store the values — _on_level_up's tween will handle the bar
		_pending_xp = current_xp
		_pending_xp_needed = xp_needed
		return
	
	xp_bar.max_value = xp_needed
	var tween = create_tween()
	tween.tween_property(xp_bar, "value", current_xp, 0.3) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)

func _on_level_up(new_level: int) -> void:
	_old_max_value = xp_bar.max_value
	_leveling_up = true
	var tween = create_tween()
	tween.tween_property(xp_bar, "value", _old_max_value, 0.3) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(func():
		# Show panel while bar is still full
		level_up_bar_complete.emit(new_level)
	)


func _on_level_up_choice_made() -> void:
	# Panel is closing — reset bar to overflow XP
	_leveling_up = false
	xp_bar.max_value = _pending_xp_needed
	xp_bar.value = 0.0
	var tween = create_tween()
	tween.tween_property(xp_bar, "value", _pending_xp, 0.3) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
