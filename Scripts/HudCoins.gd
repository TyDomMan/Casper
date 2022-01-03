extends Control

onready var coins = 0
onready var coinsbeforelevel = 0
onready var coinhud = $CoinCollector/Coins

onready var BoxPossV = $PossesInterface/Box.visible
onready var FanPossV = $PossesInterface/Fan.visible

func _process(delta):
	coinhud.text = String(coins)
	pass
