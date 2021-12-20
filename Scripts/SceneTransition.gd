extends CanvasLayer


signal scene_changed()

onready var animation_player = $AnimationPlayer
onready var black = $Control/Sprite

func change_scene(path, delay = 0.5 ):
	yield(get_tree().create_timer(delay),"timeout")
	animation_player.play("slide")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("slide")
	emit_signal("scene_changed")
	pass
