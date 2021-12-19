extends Particles2D

func _physics_process(delta):
	
	var motion = Vector2()
	var groundlocation 
	var inair = 1
	Engine.set_target_fps(Engine.get_iterations_per_second())
	
	# Particle Going Left and Right and Idle
#	if Input.is_action_pressed("ui_right"):
#		emitting = true
#		global_rotation_degrees = -160
#
#	elif Input.is_action_pressed("ui_left"):
#		emitting = true
#		global_rotation_degrees = 340
#	else:
#		emitting = false
#
#	if Input.is_action_pressed("ui_up"):
#		emitting = false
#	pass
#
	
	
