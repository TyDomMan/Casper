extends Area2D

onready var Player = get_parent().get_node("active_manager/Player")
onready var Bars = get_parent().get_parent().get_node("/root/CutsceneBars/CenterContainer/AnimationPlayer")
onready var Cam = get_parent().get_node("active_manager/Player/Transition")

var talk = false
var chatcompleted = false 

signal talking
signal nottalking

func _ready():
	connect("body_entered", self, '_on_Crow_body_entered')
	connect("body_exited", self, '_on_Crow_body_excited')


func _process(delta):
	if talk == false:
		$QuestionE.visible = false
	if  talk == true && chatcompleted == false:
		$QuestionE.visible = true
	pass

func _input(event):
	if get_node_or_null('Dialogic') == null:
		var dialog = Dialogic.start('Level2')
		if  talk == true && Input.is_action_just_pressed("player_switch") && chatcompleted == false:
			Bars.play("Bars")
			$AudioStreamPlayer2D.play()
			Player.talking = true
			emit_signal("talking")
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)
			chatcompleted = true

func unpause(timeline_name):
	emit_signal("nottalking")
	$AnimatedSprite.play("Eating")
	$QuestionE.visible = false
	Bars.play_backwards("Bars")
	Player.talking = false

func _on_Crow_body_entered(body):
	if body.get("TYPE") == ("Player"):
		$AnimatedSprite.play("Talking")
		talk = true

func _on_Crow_body_excited(body):
	if body.get("TYPE") == ("Player"):
		talk = false
		chatcompleted = false
