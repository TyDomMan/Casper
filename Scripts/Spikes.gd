extends KinematicBody2D

func _on_Area2D_body_entered(body):
	if body.get("TYPE") == ("Player"):
		$Hit.play()
		get_tree().reload_current_scene()
		
#	if body.get("TYPE") == ("Box"):
#		$Hit.play()
#		get_tree().reload_current_scene()
#
	if body.get("TYPE") == ("Fan"):
		$Hit.play()
		get_tree().reload_current_scene()
	pass # Replace with function body.
