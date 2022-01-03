extends KinematicBody2D
const UP = Vector2(0, -1)
const ACCELERATION = 30
const GRAVITY = 10
const MAX_SPEED = 55
const MAXY_SPEED = 350
const JUMP_HEIGHT = -75

onready var lerping = true
onready var possess_areaBox : Area2D = $Area2D
onready var BoxUI  = get_node("/root/Interface/Control/PossesInterface/Box")

var motion = Vector2()
var CanJumpNoGround = true
var jumpWasPressed = false
var dubjumps = 0
var maxjumps = 1 

const TYPE = 'Box'

onready var active = false
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
		$Light2D3.enabled = true
		if Input.is_action_pressed("ui_right"):
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		elif Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		else:
			motion.x = lerp(motion.x, 0, 0.3)
			friction = true
		#Jumping system
		if Input.is_action_just_pressed("ui_up"):
			jumpWasPressed = true
			rememberJumpTime()
			if CanJumpNoGround == true:
				motion.y = JUMP_HEIGHT
				
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
	elif active == false:
		move_and_slide(motion,UP)
		motion.x = lerp(motion.x, 0, 0.3)
		$Light2D3.enabled = false
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
		BoxUI.visible = true
	pass # Replace with function body.

func _on_Area2D_body_exited(body):
	if body.get("TYPE") == ("Player"):
		BoxUI.visible = false
	pass # Replace with function body.
