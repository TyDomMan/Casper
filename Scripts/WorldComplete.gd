#WorldComplete.gd
extends KinematicBody2D


export(String, FILE, "*.tscn") var world_scene

signal scene_changed()
signal dataloaded


onready var globals = get_parent().get_node("/root/Globals")
onready var animation_player = $AnimationPlayer
onready var black = $Control/Sprite
onready var sprit = $Sprite
onready var UI = get_node("/root/Interface/Control")
onready var colli = $CollisionShape2D

func _ready():
	openscene()
	pass


func _on_Area2D_body_entered(body):
	if body.get("TYPE") == ("Player"):
		colli.disabled = true
		sprit.visible = false
		$Complete.play()
		Globals.camera.shake(200,.2,200)
		UI.coinsbeforelevel = UI.coins
		change_scene(world_scene, 0.01)
	elif body.get("TYPE") == ("Fan"):
		colli.disabled = true
		sprit.visible = false
		$Complete.play()
		Globals.camera.shake(200,.2,200)
		UI.coinsbeforelevel = UI.coins
		change_scene(world_scene, 0.01)
	elif body.get("TYPE") == ("Box"):
		colli.disabled = true
		sprit.visible = false
		$Complete.play()
		Globals.camera.shake(200,.2,200)
		UI.coinsbeforelevel = UI.coins
		change_scene(world_scene, 0.01)
pass


func change_scene(path, delay = 0.5 ):
	yield(get_tree().create_timer(delay),"timeout")
	animation_player.play("slide")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	emit_signal("scene_changed")
	pass

func openscene(delay = 2):
	animation_player.play_backwards("slidelong")
	yield(get_tree().create_timer(delay),"timeout")

func _on_Spikes_spikehit():
	pass # Replace with function body.
