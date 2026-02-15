extends RichTextLabel

func _process(delta):
	clear()
	push_color(Color.GREEN)
	append_text("%s$" %UpgradeGlobals.money)
