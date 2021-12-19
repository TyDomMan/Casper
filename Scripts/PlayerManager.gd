extends Node

onready var active = 1 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
	

func _process(delta):
	
	if Input.is_action_just_pressed("ui_focus_next"):
		if active != 3:
			active += 1
		else:
			active = 1
	
	pass
