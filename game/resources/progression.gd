extends Node
class_name Progression

signal level_up(new_level: int)

@export var current_xp: int = 0
@export var current_level: int = 1
@export var gold: int = 0


# Quadratic XP curve: level 1->2 needs 120xp, 2->3 needs 280xp, 3->4 needs 480xp, 4->5 needs 720xp, 5->6 needs 1000xp, etc
func get_xp_for_level(level: int) -> int:
	return level * 100 + level * level * 20

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
	
