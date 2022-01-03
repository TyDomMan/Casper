extends Position2D

onready var Host = get_parent().get_parent()

func _process(delta):
	var target = Host.currenthostpos
	var target_pos_x
	var target_pos_y
	target_pos_x = int(lerp(global_position.x, target.x, 0.5))
	target_pos_y = int(lerp(global_position.y, target.y, 0.5))
	global_position = Vector2(target_pos_x, target_pos_y)
