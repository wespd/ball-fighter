extends RichTextLabel

func _process(delta):
	text = ""
	text = "Round %s" %UpgradeGlobals.round_number
