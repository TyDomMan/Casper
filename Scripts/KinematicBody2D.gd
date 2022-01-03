extends KinematicBody2D

const TYPE = 'Player'
const UP = Vector2(0, -1)
const ACCELERATION = 30
const GRAVITY = 9.8
const MAX_SPEED = 110
const MAXY_SPEED = 320
const JUMP_HEIGHT = -245
const GLIDFALLY_SPEED = 40
const GLIDFALLX_SPEED = 80

var motion = Vector2()
var CanJumpNoGround = true
var jumpWasPressed = false
var talking = false
var dubjumps = 0
var maxjumps = 1 

onready var active = true
onready var Bars = get_parent().get_parent().get_node("/root/CutsceneBars/CenterContainer/AnimationPlayer")
onready var UI  = get_node("/root/Interface/Control")
onready var lerping = true
onready var Death = false

#Movement System
func _physics_process(delta):
	var PlayerPos = position
	var friction = false
	
	Engine.set_target_fps(Engine.get_iterations_per_second())
	motion.y += GRAVITY
	
	#Death
	if Death == true:
		$Death.visible = true
	
	#Going Left and Right and Idle
	if (active == true) && (talking == false):
		$Sprite.visible = true
		$CollisionShape2D.disabled = false
		$Light2D.enabled = true
		if Input.is_action_pressed("ui_right"):
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$CollisionShape2D.position.x = 1
			if motion.x > 0:
				$Sprite.play("Walk")
				$Sprite/Particles2D.emitting = true
			if motion.x <= 30:
				$Sprite.play("Idle")
				$Sprite/Particles2D.emitting = false
				$Sprite/Particles2D.position.x = -5.271
				$Sprite/Particles2D.scale.x = 0.56
			if motion.y == 10:
				$Sprite/Particles2D.emitting = true
				$Sprite/Particles2D.global_rotation_degrees = -160
		elif Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			if motion.x < 0:
				$Sprite.play("Walk")
				$CollisionShape2D.position.x = 2
				$Sprite/Particles2D.emitting = true
				$Sprite/Particles2D.position.x = 7
				$Sprite/Particles2D.scale.x = -0.56
			if motion.x >= -30:
				$Sprite.play("Idle")
				$Sprite/Particles2D.emitting = false
			if motion.y == 10:
				$Sprite/Particles2D.emitting = true
				$Sprite/Particles2D.global_rotation_degrees = 340
		else:
			motion.x = lerp(motion.x, 0, 0.3)
			$Sprite.play("Idle")
			friction = true
			$Sprite/Particles2D.emitting = false
			$CollisionShape2D.position.x = 1
			
			
		#Jumping system
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
			
	elif active == false:
		$Sprite.visible = false
		$CollisionShape2D.disabled = true
		$Light2D.enabled = false
		
	elif talking == true:
		$Sprite.play("Idle")
		motion = move_and_slide(motion, Vector2.UP/1.5)
		move_and_slide(motion,UP)
		motion.y -= -GRAVITY
		motion.x = 0
	pass

#Creates CoyoteTime From youtube
func coyoteTime():
	yield(get_tree().create_timer(.1), "timeout")
	CanJumpNoGround = false

func rememberJumpTime():
	yield(get_tree().create_timer(.1), "timeout")
	jumpWasPressed = false


func _on_Spikes_spikehit():
	Death = true
	active = false
	Globals.camera.shake(500,.2,500)


func _on_Crow_talking():
	talking = true
	Bars.play("Bars")
	
func _on_Crow_nottalking():
	talking = false
	Bars.play_backwards("Bars")


func _on_Coin_coin_collected():
	UI.coins = UI.coins + 1
	pass # Replace with function body.

