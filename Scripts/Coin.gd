extends KinematicBody2D

signal coin_collected

onready var coin = $Coin
onready var coincol = $CollisionPolygon2D
onready var coinlight = $Coin/Area2D/AnimatedSprite/Light2D
var coins = 0

func _process(delta):
	if coins > 0:
		$Area2D/CollisionShape2D.disabled = true
		$CollisionPolygon2D.disabled = true
	else:
		$Area2D/CollisionShape2D.disabled = false
		$CollisionPolygon2D.disabled = false
	pass

func _on_Area2D_body_entered(body):
	if body.get("TYPE") == ("Player"):
		emit_signal("coin_collected")
		coins = coins + 1
		$Coin.play()
		$Area2D/AnimationPlayer.set_current_animation("Collect")
		coin.visible = false
		coincol = false
	else:
		$Area2D/AnimationPlayer.set_current_animation("Idle")
		coincol = true
		coin.visible = true
		coinlight = true
		
	if body.get("TYPE") == ("Fan"):
		emit_signal("coin_collected")
		coins = coins + 1
		$Coin.play()
		$Area2D/AnimationPlayer.set_current_animation("Collect")
		coin.visible = false
		coincol = false
	else:
		$Area2D/AnimationPlayer.set_current_animation("Idle")
		coincol = true
		coin.visible = true
		coinlight = true
		
	if body.get("TYPE") == ("Box"):
		emit_signal("coin_collected")
		coins = coins + 1
		$Coin.play()
		$Area2D/AnimationPlayer.set_current_animation("Collect")
		coin.visible = false
		coincol = false
	else:
		$Area2D/AnimationPlayer.set_current_animation("Idle")
		coincol = true
		coin.visible = true
		coinlight = true
