class_name DebuffHandler
extends Node

# Array tracks all active debuffs so they can stack
var active_debuffs: Array[Debuff] = []

# Creates a new Debuff resource and adds it to the active list
func apply_debuff(debuff_type: String, strength: float, duration: float) -> void:
	# Skip zero/negative durations to avoid permanent debuffs
	if duration <= 0.0:
		return
	var d := Debuff.new()
	d.debuff_type = debuff_type
	d.strength = strength
	d.duration = duration
	active_debuffs.append(d)

func _process(delta: float) -> void:
	# Tick elapsed time on each debuff
	for d in active_debuffs:
		d.elapsed += delta
	# Remove expired debuffs
	# filter() creates a new array keeping only unexpired ones
	active_debuffs = active_debuffs.filter(func(x: Debuff) -> bool:
		return x.elapsed < x.duration)

# Returns a multiplier (0.2 to 1.0) for enemy speed
# Multiplicative stacking — two 30% slows = 0.7 * 0.7 = 0.49 (not 0.4)
# This feels fairer than additive and prevents instant freeze
func get_total_slow_factor() -> float:
	var factor := 1.0
	for d in active_debuffs:
		if d.debuff_type == "slow":
			factor *= (1.0 - d.strength)
	# Clamp so enemies always move at least 20% speed
	return clamp(factor, 0.2, 1.0)
