extends Node

var hp: HealthComponent
var health_changed_log: Array = []
var died_count: int = 0

func _ready() -> void:
	_run_tests()

func _setup_component(max_value: float = 100.0) -> void:
	if hp:
		hp.queue_free()
	hp = HealthComponent.new()
	hp.max_hp = max_value
	add_child(hp)
	health_changed_log.clear()
	died_count = 0
	hp.health_changed.connect(func(c, m): health_changed_log.append([c, m]))
	hp.died.connect(func(): died_count += 1)

func _assert(label: String, condition: bool) -> void:
	var tag := "PASS" if condition else "FAIL"
	print("[%s] %s" % [tag, label])

func _run_tests() -> void:
	print("=== HealthComponent tests ===")

	_setup_component(100.0)
	_assert("init: current_hp equals max_hp", hp.current_hp == 100.0)

	hp.take_damage(30.0)
	_assert("damage: hp = 70", hp.current_hp == 70.0)
	_assert("damage: signal payload [70, 100]", health_changed_log[-1] == [70.0, 100.0])

	hp.take_damage(999.0)
	_assert("overkill: hp clamps to 0", hp.current_hp == 0.0)
	_assert("overkill: died emitted once", died_count == 1)

	hp.take_damage(50.0)
	_assert("dead: take_damage ignored", died_count == 1)

	_setup_component(100.0)
	hp.take_damage(40.0)
	hp.heal(20.0)
	_assert("heal: hp = 80", hp.current_hp == 80.0)
	hp.heal(999.0)
	_assert("overheal: clamps to max_hp", hp.current_hp == 100.0)

	_setup_component(100.0)
	hp.set_max_hp(150.0)
	_assert("set_max_hp larger: max = 150, current = 100", hp.max_hp == 150.0 and hp.current_hp == 100.0)
	hp.set_max_hp(50.0)
	_assert("set_max_hp smaller: current clamps to 50", hp.current_hp == 50.0)
	hp.set_max_hp(-10.0)
	_assert("set_max_hp negative: clamps to 0", hp.max_hp == 0.0 and hp.current_hp == 0.0)

	print("=== Done ===")
