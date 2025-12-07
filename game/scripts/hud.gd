extends CanvasLayer

@onready var hp_label: Label = $HPLabel


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

func update_hp(current: float, max_hp: float) -> void:
	hp_label.text = "HP: %d/%d" % [current, max_hp]
