extends RichTextLabel

var amount : float = 0.0

func _ready():
	UpgradeGlobals.money += amount
	UpgradeGlobals.money = roundf(UpgradeGlobals.money * 10) / 10
	UpgradeGlobals.money_this_round += amount
	UpgradeGlobals.money_this_round = roundf(UpgradeGlobals.money_this_round * 10) / 10
	text = "[color=green][shake rate=10.0 level=4 connected=1]+%s$" %amount
	var tweener = get_tree().create_tween()
	tweener.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).set_parallel(true)
	tweener.tween_property(self, "position", position + Vector2(randf_range(10,15),randf_range(-40,-60)), 1.0)
	tweener.tween_property(self, "self_modulate", Color(1.0,1.0,1.0,0.0), 1.0)
	tweener.finished.connect(queue_free)
