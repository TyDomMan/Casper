extends MarginContainer

func _on_Fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	pass # Replace with function body.
	
func _on_Vsync_pressed():
	OS.vsync_enabled = !OS.vsync_enabled
	pass

onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector
onready var selector_four = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/Selector
onready var selector_five = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer5/HBoxContainer/Selector
onready var selector_six = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer6/HBoxContainer/Selector

var current_selection = 0 

func _ready():
	set_current_selection(0)
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_down") and current_selection < 5:
		current_selection += 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_up") and current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)
	pass

func handle_selection(_current_selection):
	if _current_selection == 0:
		_on_Fullscreen_pressed()
	elif _current_selection == 1:
		_on_Vsync_pressed()
	elif _current_selection == 2:
		return
	elif _current_selection == 3:
		return
	elif _current_selection == 4:
		return
	elif _current_selection == 5:
		get_tree().change_scene("res://Scnes/Interface/MainMenu.tscn")
	pass



func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	selector_four.text = ""
	selector_five.text = ""
	selector_six.text = ""
	
	if _current_selection == 0:
		selector_one.text = ">"
	elif _current_selection == 1:
		selector_two.text = ">"
	elif _current_selection == 2:
		selector_three.text = ">"
	elif _current_selection == 3:
		selector_four.text = ">"
	elif _current_selection == 4:
		selector_five.text = ">"
	elif _current_selection == 5:
		selector_six.text = ">"
