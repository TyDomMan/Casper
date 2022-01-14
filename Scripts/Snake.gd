extends KinematicBody2D

onready var snakepos = global_position
onready var ani = $AnimatedSprite

var velocity = Vector2.ZERO
var gravity = 10
var is_moving_left = false
var Player = null

var speed = 50

func _ready():
	ani.play("Walking")
	ani.animation = "Walking"

func _physics_process(delta):
	if $AnimationPlayer.current_animation == "Attack":
		return
	move_character()
	detect_turn_around()
	velocity = move_and_slide(velocity, Vector2.UP)

func move_character():
	velocity.x = speed if is_moving_left else speed
	velocity.y += gravity
func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		speed = -speed
		scale.x = -scale.x

func hit():
	$AttackPlayer.monitoring = true
	speed = speed * 1.4
func end_of_hit():
	$AttackPlayer.monitoring = false
	speed = speed / 1.4
func start_walk():
	$AnimatedSprite.play("Walking")

func _on_DetectPlayer_body_entered(body):
	ani.animation = "Attack"
	$AnimationPlayer.play("Attack")
	print("seescharacter")

func _on_AttackPlayer_body_entered(body):
	print("hit")
	get_tree().reload_current_scene()
	pass

func _on_SeePlayerInRange_body_entered(body):
	Player = body

func _on_SeePlayerInRange_body_exited(body):
	Player = null

func _on_Deathcollison_body_entered(body):
	if Player:
		print("dead")
