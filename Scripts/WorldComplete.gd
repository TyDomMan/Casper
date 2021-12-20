#WorldComplete.gd
extends KinematicBody2D

export(String, FILE, "*.tscn") var world_scene

signal scene_changed()

onready var animation_player = $AnimationPlayer
onready var black = $Control/Sprite


func _on_Area2D_body_entered(body):
	if body.get("TYPE") == ("Player"):
		$Complete.play()
		change_scene(world_scene, 0.01)
	elif body.get("TYPE") == ("Fan"):
		$Complete.play()
		change_scene(world_scene, 0.01)
	elif body.get("TYPE") == ("Box"):
		$Complete.play()
		change_scene(world_scene, 0.01)
pass

func change_scene(path, delay = 0.5 ):
	yield(get_tree().create_timer(delay),"timeout")
	animation_player.play("slide")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("slide")
	emit_signal("scene_changed")
	pass

