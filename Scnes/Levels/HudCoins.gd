extends CanvasLayer

var coins = 0

func _process(delta):
	$CoinCollector/Coins.text = String(coins)
	pass

func _on_coin_collected():
	coins = coins + 1
