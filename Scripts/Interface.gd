extends Control

onready var UI  = get_node("/root/Interface/Control")

#Coin Interface
onready var coins = 0
onready var coinsbeforelevel = 0
onready var coinhud = $CoinCollector/Coins

#PossesInterface
onready var BoxPoss = $PossesInterface/Box
onready var FanPoss = $PossesInterface/Fan
onready var label = $PossesInterface/Label

#R to restart
onready var Rrestart = $HBoxContainer/Label

func _ready():
	label.visible = false
	BoxPoss.visible = false
	FanPoss.visible = false
	Rrestart.visible = false
	coinhud.visible = false

func _process(delta):
	#coins
	coinhud.text = String(coins)
	
	if get_tree().current_scene.name == "MainMenu":
		hideUI() 
	elif get_tree().current_scene.name == "Options":
		hideUI() 
	#UI visible
	elif get_tree().current_scene.name == "World":
		Rrestart.visible = true
	elif get_tree().current_scene.name == "World2":
		showUI()
	else:
		showUI()
	pass

func _input(event):
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
		UI.coins = UI.coinsbeforelevel
	pass

func hideUI():
	label.visible = false
	BoxPoss.visible = false
	FanPoss.visible = false
	Rrestart.visible = false
	coinhud.visible = false

func showUI():
	label.visible = true
	Rrestart.visible = true
	coinhud.visible = true
