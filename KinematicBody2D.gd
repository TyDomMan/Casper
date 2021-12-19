extends KinematicBody2D

const TYPE = 'Player'
const UP = Vector2(0, -1)
const ACCELERATION = 30
const GRAVITY = 10
const MAX_SPEED = 110
const MAXY_SPEED = 350
const JUMP_HEIGHT = -260
const GLIDFALLY_SPEED = 40
const GLIDFALLX_SPEED = 80

var motion = Vector2()
var CanJumpNoGround = true
var jumpWasPressed = false
var dubjumps = 0
var maxjumps = 1 

onready var active = true
#Movement System
func _physics_process(delta):
	
	var PlayerPos = position
	motion.y += GRAVITY
	var friction = false
	Engine.set_target_fps(Engine.get_iterations_per_second())
	#Going Left and Right and Idle
	if active == true:
		$Sprite.visible = true
		$CollisionShape2D.disabled = false
		$Light2D.enabled = true
		if Input.is_action_pressed("ui_right"):
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$Sprite.play("Walk")
			if motion.y == 10:
				$Sprite/Particles2D.emitting = true
				$Sprite/Particles2D.global_rotation_degrees = -160
		elif Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			$Sprite.play("Walk")
			if motion.y == 10:
				$Sprite/Particles2D.emitting = true
				$Sprite/Particles2D.global_rotation_degrees = 340
		else:
			motion.x = lerp(motion.x, 0, 0.3)
			$Sprite.play("Idle")
			friction = true
			$Sprite/Particles2D.emitting = false
		#Jumping system
		if Input.is_action_just_pressed("ui_up"):
			$Sprite/Particles2D.emitting = false
			jumpWasPressed = true
			rememberJumpTime()
			if CanJumpNoGround == true:
				motion.y = JUMP_HEIGHT
				$Sprite/AudioController/PlayerJump.play()
				dubjumps = maxjumps
			elif dubjumps > 0: 
				motion.y = JUMP_HEIGHT
				$Sprite/AudioController/PlayerJump.play()
				dubjumps = dubjumps - 1
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.1)
		else:
			if motion.y < 0: 
				$Sprite.play("Jump")
				$Sprite/Particles2D.emitting = false
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.1)
		motion = move_and_slide(motion, UP)
		
		#Max fall speed
		if motion.y > MAXY_SPEED:
			motion.y = MAXY_SPEED
		
		if is_on_floor():
			CanJumpNoGround = true
			if jumpWasPressed == true:
				$Sprite/AudioController/PlayerJump.play()
				motion.y = JUMP_HEIGHT
		
		if !is_on_floor():
			coyoteTime()
			motion.y += GRAVITY
			if motion.y > 0:
				$Sprite.play("fall")
				
	else:
		$Sprite.visible = false
		$CollisionShape2D.disabled = true
		$Light2D.enabled = false
		
		
	pass

func _input(event):
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
	pass


#Creates CoyoteTime From youtube
func coyoteTime():
	yield(get_tree().create_timer(.1), "timeout")
	CanJumpNoGround = false
	pass

func rememberJumpTime():
	yield(get_tree().create_timer(.1), "timeout")
	jumpWasPressed = false
	pass

