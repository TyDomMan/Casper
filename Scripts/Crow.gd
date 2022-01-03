extends Area2D

onready var Player = get_parent().get_node("Player")
onready var Bars = get_parent().get_node("Player/Node2D/CenterContainer/AnimationPlayer")
onready var Cam = get_parent().get_node("Player/Transition")

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
	if  talk == true && chatcompleted == true && $AnimatedSprite.play() == 'Talking':
		$QuestionE.visible = true
	pass

func _input(event):
	if get_node_or_null('Dialogic') == null:
		var dialog = Dialogic.start('Timeline1')
		if chatcompleted == false:
			if  talk == true && chatcompleted == false:
				$AudioStreamPlayer2D.play()
				disconnect("nottalking", Player, "_on_Crow_talking")
				connect("talking", Player, "_on_Crow_talking")
				emit_signal("talking")
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect('timeline_end', self, 'unpause')
				add_child(dialog)
				chatcompleted = true
			


func unpause(timeline_name):
	disconnect("talking", Player, "_on_Crow_talking")
	emit_signal("nottalking")
	connect("nottalking", Player, "_on_Crow_talking")
	$AnimatedSprite.play("Eating")

func _on_Crow_body_entered(body):
	if body.get("TYPE") == ("Player"):
		$AnimatedSprite.play("Talking")
		talk = true

func _on_Crow_body_excited(body):
	if body.get("TYPE") == ("Player"):
		talk = false
