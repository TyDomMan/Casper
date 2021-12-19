extends Camera2D

onready var Player = get_parent()

func _physics_process(delta):
	if Player.motion.x > 15 or Player.motion.y > 15 or -Player.motion.x > -15 or -Player.motion.y > -15:
		global_position = Player.global_position.round()
		force_update_scroll()
