extends KinematicBody2D

onready var animation_player = $AnimationPlayer
onready var black = $Control/Sprite
onready var hit = $Hit

func _on_Area2D_body_entered(body):
	if body.get("TYPE") == ("Player"):
		hit.play()
		death_scene()
		
#	if body.get("TYPE") == ("Box"):
#		$Hit.play()
#		get_tree().reload_current_scene()
#
	if body.get("TYPE") == ("Fan"):
		get_tree().reload_current_scene()
	pass # Replace with function body.


func death_scene( delay = 0.1 ):
	yield(get_tree().create_timer(delay),"timeout")
	animation_player.play("slide")
	yield(animation_player, "animation_finished")
	get_tree().reload_current_scene()
	animation_player.play_backwards("slide")
	emit_signal("scene_changed")
	pass
