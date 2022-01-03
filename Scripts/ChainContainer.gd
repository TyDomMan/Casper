extends RigidBody2D

const UP = Vector2(0, -1)
const ACCELERATION = 30
const GRAVITY = 9.8
const MAX_SPEED = 110
const MAXY_SPEED = 320
const JUMP_HEIGHT = -245
const GLIDFALLY_SPEED = 40
const GLIDFALLX_SPEED = 80


var motion = Vector2()

func _physics_process(delta):
	add_central_force(Vector2(0,2))
	pass
