extends Node2D

var speed = 1.0
@onready var SpikeAnimation = $AnimationPlayer
signal cat_killed

@onready var path : PathFollow2D = get_node("Path2D/PathFollow2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Saw")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path.progress_ratio += delta * speed



func _on_area_2d_body_entered(body):
# Called when a body enters the Area2D
	# El jugador es un CharacterBody2D
	if body is CharacterBody2D:
		print("Colisionando player")
		emit_signal("cat_killed")
