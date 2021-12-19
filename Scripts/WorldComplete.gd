#WorldComplete.gd
extends KinematicBody2D

export(String, FILE, "*.tscn") var world_scene

func _on_Area2D_body_entered(body):
	if body.get("TYPE") == ("Player"):
		$Complete.play()
		get_tree().change_scene(world_scene)
	elif body.get("TYPE") == ("Fan"):
		$Complete.play()
		get_tree().change_scene(world_scene)
	elif body.get("TYPE") == ("Box"):
		$Complete.play()
		get_tree().change_scene(world_scene)
pass
