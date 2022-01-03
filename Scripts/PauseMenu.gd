extends CanvasLayer

onready var selector1_one = $Contiune/Selector
onready var selector1_two = $Fullscreen/Selector2
onready var selector1_three = $Quit/Selector3

var current1_selection = 0 

func _ready():
	set_visible(false)
	set_current_selection1(0)
	pass

func _process(delta):
	if $Background.visible == true:
		get_tree().paused = true
		if Input.is_action_just_pressed("ui_down") and current1_selection < 2:
			current1_selection += 1
			set_current_selection1(current1_selection)
		elif Input.is_action_just_pressed("ui_up") and current1_selection > 0:
			current1_selection -= 1
			set_current_selection1(current1_selection)
		elif Input.is_action_just_pressed("ui_accept"):
			handle1_selection(current1_selection)
		pass
	else:
		get_tree().paused = false

func handle1_selection(_current1_selection):
	if _current1_selection == 0:
		get_tree().paused = false
		set_visible(false)
	elif _current1_selection == 1:
			OS.window_fullscreen = !OS.window_fullscreen
	elif _current1_selection == 2:
		get_tree().change_scene("res://Scnes/Interface/MainMenu.tscn")
		get_tree().paused = false
		set_visible(false)
	pass

func set_current_selection1(_current1_selection):
	selector1_one.text = ""
	selector1_two.text = ""
	selector1_three.text = ""
	
	if _current1_selection == 0:
		selector1_one.text = ">"
	elif _current1_selection == 1:
		selector1_two.text = ">"
	elif _current1_selection == 2:
		selector1_three.text = ">"

func _input(event):
	
	if get_tree().current_scene.name == "MainMenu":
		return 
	if get_tree().current_scene.name == "Options":
		return
		
	if event.is_action_pressed("Pause"):
		set_visible(!get_tree().paused)
		get_tree().paused = !get_tree().paused

func _on_Button_pressed():
	get_tree().paused = false
	set_visible(false)
	pass # Replace with function body.

func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible

func _on_Fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().change_scene("res://Scnes/Interface/MainMenu.tscn")
	get_tree().paused = false
	set_visible(false)
	pass # Replace with function body.
