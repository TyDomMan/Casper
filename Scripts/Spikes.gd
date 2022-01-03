extends KinematicBody2D

const TYPE = 'Spike'

onready var animation_player = $AnimationPlayer
onready var black = $Control/Sprite
onready var hit = $Hit
onready var spike = get_parent().get_node("Spikes")
onready var UI  = get_node("/root/Interface/Control")

signal spikehit

func _on_Area2D_body_entered(body):
	if body.get("TYPE") == ("Player"):
		hit.play()
		emit_signal("spikehit")
		death_scene()
		Globals.camera.shake(500,.2,500)
		
#	if body.get("TYPE") == ("Box"):
#		$Hit.play()
#		get_tree().reload_current_scene()
#
	if body.get("TYPE") == ("Fan") && get_node("/root/Globals").Fanactive == true:
		hit.play()
		emit_signal("spikehit")
		death_scene()

func death_scene( delay = 0.1 ):
	yield(get_tree().create_timer(delay),"timeout")
	animation_player.play("slide")
	UI.coins = UI.coinsbeforelevel
	yield(animation_player, "animation_finished")
	get_tree().reload_current_scene()
	animation_player.play_backwards("slide")
	emit_signal("scene_changed")
	pass
