extends Node
class_name Progression

signal level_up(new_level: int)

@export var current_xp: int = 0
@export var current_level: int = 1
@export var gold: int = 0


# Linear XP curve: 5, 10, 15, 20, 25, etc because we want to make it easy for the player to level up for now
# to get that feel of progression, but we can change it later if we want to make it more challenging
func get_xp_for_level(level: int) -> int:
	return 5 + (level - 1) * 5

func add_xp(amount: int) -> void:
	current_xp += amount
	check_level_up()


func add_gold(amount: int) -> void:
	gold += amount


func check_level_up() -> void:
	var xp_needed = get_xp_for_level(current_level)
	if current_xp >= xp_needed:
		current_xp -= xp_needed
		current_level += 1
		level_up.emit(current_level)
		check_level_up() # check again in case of multiple level ups

func get_progress_ratio() -> float:
	var xp_needed = get_xp_for_level(current_level)
	return float(current_xp) / float(xp_needed)
	
