extends KinematicBody2D


onready var coin = $Coin
onready var coincol = $CollisionPolygon2D
onready var coinlight = $Coin/Area2D/AnimatedSprite/Light2D
onready var cdis = 0

func _process(delta):
	if cdis > 0:
		$Area2D/CollisionShape2D.disabled = true
		$CollisionPolygon2D.disabled = true
	else:
		$Area2D/CollisionShape2D.disabled = false
		$CollisionPolygon2D.disabled = false
	pass

func _on_Area2D_body_entered(body):
	emit_signal("coin_collected")
	if body.get("TYPE") == ("Player"):
		cdis = cdis + 1
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
		cdis = cdis + 1
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
		cdis = cdis + 1
		$Coin.play()
		$Area2D/AnimationPlayer.set_current_animation("Collect")
		coin.visible = false
		coincol = false
	else:
		$Area2D/AnimationPlayer.set_current_animation("Idle")
		coincol = true
		coin.visible = true
		coinlight = true
