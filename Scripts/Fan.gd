extends KinematicBody2D

const TYPE = 'Fan'
const UP = Vector2(0, -1)
const ACCELERATION = 30
const GRAVITY = 6
const MAX_SPEED = 100
const MAXY_SPEED = 200
const JUMP_HEIGHT = -100
const WALLJUMP_HEIGHT = -300
const GLIDFALLY_SPEED = 40
const GLIDFALLX_SPEED = 80

onready var lerping = false
onready var FanUI  = get_node("/root/Interface/Control/PossesInterface/Fan")

var motion = Vector2()
var CanJumpNoGround = true
var jumpWasPressed = false
var dubjumps = 0
var maxjumps = 1 



onready var active = false
#Movement System
func _physics_process(delta):
	var PlayerPos = position
	var friction = false
	Engine.set_target_fps(Engine.get_iterations_per_second())
	
	#Going Left and Right and Idle
	if active == true:
		get_node("/root/Globals").Fanactive = true
		motion.y += GRAVITY
		$Sprite.visible = true
		$CollisionShape2D.disabled = false
		$Light2D.enabled = true
		if Input.is_action_pressed("ui_right"):
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			if motion.y > 0:
				$Sprite.play("Walk")
				$Spin.play()
		elif Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			if motion.y > 0:
				$Sprite.play("Walk")
				$Spin.play()
		else:
			motion.x = lerp(motion.x, 0, 0.3)
			if motion.y > 0:
				$Sprite.play("Idle")
				$Spin.stop()
			friction = true
		#Jumping system
		if Input.is_action_just_pressed("ui_up"):
			jumpWasPressed = true
#			$PlayerJump.play()
			rememberJumpTime()
			if CanJumpNoGround == true:
				motion.y = JUMP_HEIGHT
				dubjumps = maxjumps
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.1)
		else:
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.1)
		motion = move_and_slide(motion, UP)
		
		#Max fall speed
		if motion.y > MAXY_SPEED:
			motion.y = MAXY_SPEED
		
		if is_on_floor():
			CanJumpNoGround = true
			if jumpWasPressed == true:
				motion.y = JUMP_HEIGHT
			
		
		if !is_on_floor():
			coyoteTime()
			motion.y += GRAVITY
				
		#Spinning
		if motion.y != 0 || motion.y == 0:
			if Input.is_action_pressed("ui_up"):
				motion.y -= GRAVITY 
				motion.y = max( -ACCELERATION * 2, -MAXY_SPEED)
				$Sprite.play("Spin")
				$PlayerJump.stop()
				$Spin.play()
	elif active == false:
		get_node("/root/Globals").Fanactive = false
		motion = move_and_slide(motion, Vector2.UP/1.5)
		move_and_slide(motion,UP)
		motion.y -= -GRAVITY
		motion.x = lerp(motion.x, 0, 0.3)
		$Sprite.play("Idle")
		$Spin.stop()
		$Light2D.enabled = false
	pass
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



func _on_Area2D_body_entered(body):
	if body.get("TYPE") == ("Player"):
		FanUI.visible = true
	pass # Replace with function body.

func _on_Area2D_body_exited(body):
	if body.get("TYPE") == ("Player"):
		FanUI.visible = false
	pass # Replace with function body.
