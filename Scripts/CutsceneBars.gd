extends Control


func _process(delta):
	var animate = $CenterContainer/AnimationPlayer
	var s1 = $CenterContainer/Sprite
	var s2 = $CenterContainer/Sprite2
	if get_tree().current_scene.name == "MainMenu":
		animate.stop()
		s1.visible = false
		s2.visible = false
	elif get_tree().current_scene.name == "Options":
		animate.stop()
		s1.visible = false
		s2.visible = false
	#UI visible
	elif get_tree().current_scene.name == "World":
		return
