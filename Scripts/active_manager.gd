extends Node

onready var camera :Camera2D = $Player/Camera2D
onready var posses_area : Area2D = $Player/PossesArea
onready var switch = $Switch
onready var Player = $Player
onready var Box = $Box
onready var Fan = $Fan

func _ready():
	posessnolerp(Player)
	pass


func _input(event):
	
	var temp_state = $Box.active
	
	if (($Player.position.x - $Box.position.x <= 40) && ($Player.position.x - $Box.position.x > -40)) && ($Player.position.y - $Box.position.y >= -40) && ($Player.position.y - $Box.position.y <= 40) && ($Player/Sprite.visible == true):
		if Input.is_action_just_released("player_switch"):
			$Box.active = $Player.active
			$Fan.active = temp_state
			$Player.active = temp_state
			$Player.active = false
			$Fan.active = false
			posess(Box)
			$Switch.play()
	elif (($Player.position - $Box.position <= Vector2(1000,1000)) || ($Player.position - $Box.position >= Vector2(-1000,-1000))) && ($Player/Sprite.visible == false) && ($Box.active == true):
		if Input.is_action_just_released("player_switch"):
			$Player.active = $Box.active
			$Fan.active = temp_state
			$Box.active = temp_state
			$Box.active = false
			$Fan.active = false
			posess(Player)
			$Switch.play()
	elif (($Player.position.x - $Fan.position.x <= 40) && ($Player.position.x - $Fan.position.x > -40)) && ($Player.position.y - $Fan.position.y >= -40) && ($Player.position.y - $Fan.position.y <= 40) && ($Player/Sprite.visible == true):
		if Input.is_action_just_released("player_switch"):
			$Fan.active = $Player.active
			$Box.active = temp_state
			$Player.active = temp_state
			$Player.active = false
			$Fan.active = true
			posess(Fan)
			$Switch.play()
	elif (($Player.position - $Fan.position <= Vector2(1000,1000)) || ($Player.position - $Fan.position >= Vector2(-1000,-1000))) && ($Player/Sprite.visible == false) && ($Fan.active == true):
		if Input.is_action_just_released("player_switch"):
			$Player.active = $Fan.active
			$Fan.active = temp_state
			$Box.active = temp_state
			$Box.active = false
			$Fan.active = false
			posessnolerp(Player)
			$Player.global_position = $Fan.global_position + Vector2(-10,-10)
			$Switch.play()
			
	pass

func posess(host : Node2D):
	
	#Store Camera position
	var current_host = camera.get_parent()
	var camera_pos = camera.global_position
	
	#reaprrent
	current_host.remove_child(camera)
	host.add_child(camera)
	camera.set_owner(host)
	
	#setting location
	camera.global_position = camera_pos
	
	#tweening
	var Tweening : Tween = camera.get_node("Tween")
	Tweening.remove_all()
	Tweening.interpolate_property(camera, "position", camera.position, Vector2(), .4)
	Tweening.start()
	
	current_host.active = false
	host.active = true
	switch.play()
pass

func posessnolerp(host : Node2D):
	
	#Store Camera position
	var current_host = camera.get_parent()
	var camera_pos = camera.global_position
	
	#reaprrent
	current_host.remove_child(camera)
	host.add_child(camera)
	camera.set_owner(host)
	
	#setting location
	camera.global_position = camera_pos
	
	#tweening
	var Tweening : Tween = camera.get_node("Tween")
	Tweening.remove_all()
	Tweening.interpolate_property(camera, "position", camera.position, Vector2(), .01)
	Tweening.start()
	
	current_host.active = false
	host.active = true
#	switch.play()
pass



	#Fullscreen 
func Fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen
	
	pass

