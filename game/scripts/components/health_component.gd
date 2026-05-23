extends Node
class_name HealthComponent

signal health_changed(current: float, max: float)
signal died

@export var max_hp: float = 100.0
var current_hp: float

func _ready() -> void:
	current_hp = max_hp

func take_damage(amount: float) -> void:
	if current_hp <= 0.0:
		return
	current_hp = max(current_hp - amount, 0.0)
	health_changed.emit(current_hp, max_hp)
	if current_hp <= 0.0:
		died.emit()

func heal(amount: float) -> void:
	if current_hp <= 0.0:
		return
	current_hp = min(current_hp + amount, max_hp)
	health_changed.emit(current_hp, max_hp)

func set_max_hp(value: float) -> void:
	max_hp = max(value, 0.0)
	current_hp = min(current_hp, max_hp)
	health_changed.emit(current_hp, max_hp)
