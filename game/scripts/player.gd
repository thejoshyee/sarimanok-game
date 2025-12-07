extends CharacterBody2D

@export var stats: PlayerStats

@onready var damage_area: Area2D = $DamageArea

# Runtime State
var current_hp: float
var is_invincible: bool = false
var invincibility_duration: float = 0.5

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

func take_damage(amount: float) -> void:
	# dont take damage if invincible
	if is_invincible:
		return

	# apply damage
	current_hp -= amount
	print("Player took ", amount, " damage. HP: ", current_hp, "/", stats.max_hp)

	# start invincibility frames
	is_invincible = true
	await get_tree().create_timer(invincibility_duration).timeout
	is_invincible = false

func _ready() -> void:
	current_hp = stats.max_hp # start at full health 
	damage_area.body_entered.connect(_on_damage_area_body_entered)

func _on_damage_area_body_entered(body: Node2D) -> void:
	# check if the body that hits us is an enemy
	if body.is_in_group("enemies"):
		take_damage(10.0) # placeholder damage
