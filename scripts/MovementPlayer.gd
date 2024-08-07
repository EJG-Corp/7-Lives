extends CharacterBody2D

@onready var pivot : Node2D = $Pivot
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var camera_2d = $Camera2D

signal cat_died

var speed = 300
var jump_speed = 300
var gravity = 800
var acceleration = 2000
var player_alive = true

func jump():
	# Jump Input
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed

func _physics_process(delta:float) -> void:
	handle_respawn()
	# Gravity 
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if player_alive: 
		jump()

		# Movement Input	
		var move_input = Input.get_axis("move_left","move_right")
		velocity.x = move_toward(velocity.x,move_input*speed,acceleration*delta)
		# Animation Movement
		handle_animation_movement(move_input)
	else:
		# Friction to Die
		velocity.x = move_toward(velocity.x, 0, 200*delta)
	move_and_slide()

func handle_animation_movement(move_input):
	if is_on_floor():
		if abs(velocity.x) > 10 or move_input != 0:
			playback.travel("Run")
		else:
			playback.travel("Idle")
	else:
		if velocity.y < 0 :
			playback.travel("Jump")
		else:
			playback.travel("Fall")
		
	# Rotate the character
	if move_input:
		pivot.scale.x = sign(move_input)
	
func handle_respawn():
	if player_alive:
		if Input.is_action_just_pressed("respawn"):
			emit_signal("cat_died")
			playback.travel("Die")
			player_alive = false

func get_camera2d():
	return camera_2d
	
func disable_camera():
	camera_2d.queue_free()

