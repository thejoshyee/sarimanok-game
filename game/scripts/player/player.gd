extends CharacterBody2D

@export var stats: PlayerStats

@onready var damage_area: Area2D = $DamageArea
@onready var sprite: ColorRect = $VisualSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var weapon_manager = $WeaponManager
@onready var pickup_area: Area2D = $PickupArea
@onready var progression: Progression = ProgressionManager
@onready var pickup_shape: CircleShape2D = $PickupArea/CollisionShape2D.shape

# Runtime State
var current_hp: float
var is_invincible: bool = false
var invincibility_duration: float = 0.5

signal player_died


func _physics_process(_delta: float) -> void:
	# Get input as floats (0.0 to 1.0) - works for both keyboard and analog sticks
	var horizontal = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var vertical = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	# build movement vector
	var input_vector = Vector2(horizontal, vertical) 

	# normalize so diagonal movement isn't faster than cardinal
	if input_vector.length() > 1.0:
		input_vector = input_vector.normalized()

	# Apply Racing Legs passive: +10% move speed per level
	velocity = input_vector * stats.move_speed * PassiveManager.get_modifier("racing_legs")
	move_and_slide()

	# handle animation and sprite flipping
	if velocity.length() > 0:
		animation_player.play("walk")
		# flip sprite based on horizontal movement
		if velocity.x != 0:
			sprite.scale.x = -1 if velocity.x > 0 else 1
	else:
		animation_player.play("idle")


func take_damage(amount: float) -> void:
	# dont take damage if invincible
	if is_invincible:
		return

	# apply damage
	current_hp -= amount
	print("Player took ", amount, " damage. HP: ", current_hp, "/", get_effective_max_hp())

	# check for death
	if current_hp <= 0:
		die()
		return

	# start invincibility frames with visual feedback
	is_invincible = true
	start_invincibility_blink()
	await get_tree().create_timer(invincibility_duration).timeout
	is_invincible = false
	sprite.modulate.a = 1.0 # make sure to be visible again



func heal(amount: float) -> void:
	current_hp = min(current_hp + amount, get_effective_max_hp())
	print("Player healed ", amount, " HP. HP: ", current_hp, "/", get_effective_max_hp())


func start_invincibility_blink() -> void:
	# blink 5 times during invincibility (0.5s / 0.1s per blink)
	for i in range(5):
		sprite.modulate.a = 0.3 # semi-transparent
		await get_tree().create_timer(0.05).timeout
		sprite.modulate.a = 1.0 # full visible
		await get_tree().create_timer(0.05).timeout


func die() -> void:
	player_died.emit()
	print("Player died")
	# Use call_deferred to avoid removing collision objects during physics callback
	get_tree().call_deferred("reload_current_scene")
	

func _ready() -> void:
	add_to_group("player")
	current_hp = get_effective_max_hp()
	damage_area.body_entered.connect(_on_damage_area_body_entered)
	pickup_area.area_entered.connect(_on_pickup_area_area_entered)

	# Update HP when passives change (e.g., Thick Plumage increases max HP)
	PassiveManager.passive_upgraded.connect(_on_passive_upgraded)

	# connect WeaponManager to this player
	$WeaponManager.player = self

	# Test: Add Peck weapon via add_weapon()
	var peck_data = preload("res://weapons/data/peck.tres")
	if weapon_manager.add_weapon(peck_data):
		print("Peck weapon added successfully")
	else:
		print("Failed to add Peck weapon")

	_update_pickup_range()




func _on_damage_area_body_entered(body: Node2D) -> void:
	# check if the body that hits us is an enemy
	if body.is_in_group("enemies") and "damage" in body:
		take_damage(body.damage) # use enemy's actual damage stat
	# dont take damage if invincible


func _on_pickup_area_area_entered(area: Area2D) -> void:
	# Check if the area is an XP gem
	if area.is_in_group("xp_gems"):
		# Get XP value and add it to progression
		var xp_value = area.xp_value
		progression.add_xp(xp_value)
		print("Collected ", xp_value, " XP. Total: ", progression.current_xp, " Level: ", progression.current_level)

		# Play pickup SFX on the gem before despawning
		var sfx := area.get_node_or_null("AudioStreamPlayer2D")
		if sfx:
			sfx.play()

		# Despawn the gem back to the pool
		PoolManager.despawn(area)

	# Check if the area is a gold coin
	if area.is_in_group("gold_coins"):
		# Get gold value and add it to permanent gold
		var gold_value = area.gold_value
		ProgressionManager.add_gold(gold_value)
		print("Collected ", gold_value, " gold. Total: ", ProgressionManager.gold)
		PoolManager.despawn(area)


# Returns max HP including passive bonuses (Thick Plumage: +15 HP/level)
func get_effective_max_hp() -> float:
	return stats.max_hp + PassiveManager.get_bonus("thick_plumage")


# Apply Magnetic Aura passive: +20% pickup range per level
func _update_pickup_range() -> void:
	pickup_shape.radius = stats.pickup_range * PassiveManager.get_modifier("magnetic_aura")


func _on_passive_upgraded(passive_id: String, _new_level: int) -> void:
	# When Thick Plumage upgrades, increase current HP by the per-level bonus
	if passive_id == "thick_plumage":
		var bonus = PassiveManager.get_passive("thick_plumage").bonus_per_level
		current_hp += bonus

	if passive_id == "magnetic_aura":
		_update_pickup_range()
