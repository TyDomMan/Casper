extends MarginContainer

const SAVE_DIR = "user://saves/"

onready var selector_one = $StartMenu/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_two = $StartMenu/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/Selector
onready var selector_three = $StartMenu/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
onready var selector_four = $StartMenu/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector
onready var Sound = $AudioStreamPlayer

onready var animation = $StartMenu/VBoxContainer/VBoxContainer/AnimationPlayer

var current_selection = 0 

func _ready():
	animation.play("Fadein")
	set_current_selection(0)
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_page_down") and current_selection < 3:
		current_selection += 1
		set_current_selection(current_selection)
		Sound.play()
	elif Input.is_action_just_pressed("ui_page_up") and current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
		Sound.play()
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)
		Sound.play()
		
	pass

func handle_selection(_current_selection):
	if _current_selection == 0:
		get_tree().change_scene("res://Scnes/Levels/Level1.tscn")
		queue_free()
	elif _current_selection == 1:
		print("player_dahelp")
	elif _current_selection == 2:
		get_tree().change_scene("res://Scnes/Interface/Options.tscn")
		queue_free()
	elif _current_selection == 3:
		get_tree().quit()
	pass



func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	selector_four.text = ""
	
	if _current_selection == 0:
		selector_one.text = ">"
	elif _current_selection == 1:
		selector_two.text = ">"
	elif _current_selection == 2:
		selector_three.text = ">"
	elif _current_selection == 3:
		selector_four.text = ">"


func _on_OptionName_pressed():
	get_tree().change_scene("res://Scnes/Levels/Level1.tscn")
	queue_free()
	pass # Replace with function body.



func _on_Load_pressed():
	pass # Replace with function body.


func _on_Exit_pressed():
	get_tree().quit()
