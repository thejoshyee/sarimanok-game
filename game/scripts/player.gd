extends CharacterBody2D

@export var stats: PlayerStats

@onready var damage_area: Area2D = $DamageArea
@onready var sprite: ColorRect = $VisualSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

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

	# apply movement
	velocity = input_vector * stats.move_speed
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
	print("Player took ", amount, " damage. HP: ", current_hp, "/", stats.max_hp)

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
	# for now restart the scene
	get_tree().reload_current_scene()
	

func _ready() -> void:
	add_to_group("player")
	current_hp = stats.max_hp # start at full health 
	damage_area.body_entered.connect(_on_damage_area_body_entered)

	# connect WeaponManager to this player
	$WeaponManager.player = self

	# test WeaponManager
	# _test_weapon_manager()


func _on_damage_area_body_entered(body: Node2D) -> void:
	# check if the body that hits us is an enemy
	if body.is_in_group("enemies"):
		take_damage(10.0) # placeholder damage
	# dont take damage if invincible


# TEMP: Test WeaponManager setup
# func _test_weapon_manager() -> void:
# 	print("=== WeaponManager Test ===")
# 	print("Weapon slots: ", $WeaponManager.weapon_slots.size())
# 	print("Damage multiplier: ", $WeaponManager.get_damage_multiplier())
# 	print("Attack speed multiplier: ", $WeaponManager.get_attack_speed_multiplier())
	
# 	# Test cooldown
# 	$WeaponManager.set_cooldown(0, 2.0)
# 	print("Slot 0 cooldown set to 2.0")
# 	print("Slot 0 is ready: ", $WeaponManager.is_ready(0))
	
# 	await get_tree().create_timer(2.5).timeout
# 	print("After 2.5 seconds, Slot 0 is ready: ", $WeaponManager.is_ready(0))
