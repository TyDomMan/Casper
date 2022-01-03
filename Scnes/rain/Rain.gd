extends AudioStreamPlayer

var played = false

func _process(delta):
	if get_tree().current_scene.name == "MainMenu":
		$RainMusic.stop()
		return 
	elif get_tree().current_scene.name == "Options":
		$RainMusic.stop()
		return
	elif played == false:
		Rain.autoplay = true
		$RainMusic.autoplay = true
		$RainMusic.play()
		played = true
