extends Node

onready var camera :Camera2D = $Player/Transition
onready var possess_area : Area2D = $Player/Area2D
onready var posfanetc : Area2D = $Player/Fanetc
onready var switch = $Switch

onready var currenthostpos = camera.get_parent().global_position
onready var UI  = get_node("/root/Interface/Control")
onready var Player = $Player
onready var Box = $Box.visible
onready var Fan = $Fan.visible
onready var Fanactive = get_node("/root/Globals").Fanactive
onready var willlerp = true

func _input(event):
	#Player goes to original spot
	if Input.is_action_just_pressed("player_switch") && possess_area.get_overlapping_bodies().size() > 0 && Player.active == true && willlerp == true:
		posess(possess_area.get_overlapping_bodies()[0]) 
		Player.active = false
		willlerp = true
	elif Input.is_action_just_pressed("player_switch") && Player.active == false && willlerp == true:
		posess(Player)
		Player.active = true
		
	#Player takes objects spot
	elif Input.is_action_just_pressed("player_switch") && posfanetc.get_overlapping_bodies().size() > 0 && Player.active == true :
		posessnolerp(posfanetc.get_overlapping_bodies()[0]) 
		willlerp = false
		Player.active = false
	elif Input.is_action_just_pressed("player_switch") && Player.active == false && willlerp == false:
		posessnolerp(Player)
		Player.active = true
		willlerp = true
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
	Globals.camera.shake(500,.2,500)
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
	Player.global_position = current_host.global_position + Vector2(0,-16)
	
	current_host.active = false
	host.active = true
	switch.play()
	Globals.camera.shake(300,.1,300)
pass



