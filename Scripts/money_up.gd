extends RichTextLabel

var amount : float = 0.0

func _ready():
	UpgradeGlobals.money += amount
	text = "[color=green]+%s$" %int(amount)
	var tweener = get_tree().create_tween()
	tweener.tween_property(self, "position", position + Vector2(randf_range(10,15),randf_range(-40,-60)), 1.0)
	tweener.finished.connect(queue_free)
