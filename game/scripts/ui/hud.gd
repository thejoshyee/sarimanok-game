extends CanvasLayer

@onready var hp_label: Label = $MarginContainer/VBoxContainer/HPLabel
@onready var cooldown_label: Label = $MarginContainer/VBoxContainer/CooldownLabel
@onready var stats_label: Label = $MarginContainer/VBoxContainer/StatsLabel


func _ready() -> void:
	# find the player and connect to it
	var player = get_tree().get_first_node_in_group("player")
	if player:
		update_hp(player.current_hp, player.stats.max_hp)

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
