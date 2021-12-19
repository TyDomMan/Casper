extends KinematicBody2D

onready var haskey = false
onready var doorkey = false
onready var keyshow = $CanvasLayer/HBoxContainer2

func _process(delta):
	var sound_has_played = false
	
	if haskey == true :
		$Key/Area2D/CollisionShape2D.disabled = true
		keyshow.visible = true
	else:
		keyshow.visible = false

	if doorkey == true:
		$Door/CollisionShape2D.disabled = true
		$Door/Door/Sprite.visible = false
		$Door/Door/Sprite2.visible = true
		$Coverup.visible = false
		$Door/Open.stop()
	pass

func _on_Area_body_entered(body):
	
	var ppos = get_node("active_manager/Player").global_position
	var pvos = get_node("active_manager/Player").get("motion")
	var tranpor = get_node("Portal2").global_position

	if body.get("TYPE") == ("Player"):
		$active_manager/Player.global_position = tranpor
		$active_manager/Player.motion.x = -pvos.y * 2
		$active_manager/Switch.play()
	elif body.get("TYPE") == ("Fan"):
		$active_manager/Fan.global_position = tranpor
		$active_manager/Fan.motion.x = -pvos.y * 2
		$active_manager/Switch.play()
pass

func _on_Area2D_body_entered(body):
	if body.get("TYPE") == ("Fan"):
		$Key.visible = false
		haskey = true
		$Key/Key.play()
	elif body.get("TYPE") == ("Player"):
		$Key.visible = false
		haskey = true
		$Key/Key.play()
	else:
		$Key/Key.stop()
	pass # Replace with function body.

func _on_Door_body_entered(body):
	if (body.get("TYPE") == ("Player")) && (haskey == true):
		doorkey = true
		$Door/Open.play()
	elif (body.get("TYPE") == ("Fan")) && (haskey == true):
		doorkey = true
		$Door/Open.play()
	pass # Replace with function body.
