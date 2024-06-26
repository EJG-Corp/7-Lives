extends MarginContainer

@onready var start = %Start
@onready var options = %Options
@onready var credits = %Credits
@onready var quit = %Quit


# Called when the node enters the scene tree for the first time.
func _ready():
	start.pressed.connect(_on_start_pressed)
	quit.pressed.connect(_on_quit_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_start_pressed():
	var new_scene = load("res://scenes/Levels/Level-1.tscn")
	get_tree().change_scene_to_packed(new_scene)
	
func _on_quit_pressed():
	get_tree().quit()
