extends CanvasLayer

var coins = 0 

func _ready():
	$CoinCollector/Coins.text = String(coins)
	pass
