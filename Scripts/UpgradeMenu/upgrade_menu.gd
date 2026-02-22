extends CanvasLayer

@onready var item_description = $ItemDescription
@onready var next_level = $NextLevel
@onready var fx_player = $FXPlayer

func _ready():
	hide()
	for upgrade in get_children():
		if upgrade is UpgradeButton:
			upgrade.mouse_entered.connect(_on_upgrade_button_hovered.bind(upgrade))
			upgrade.mouse_exited.connect(_on_upgrade_button_unhovered)
			upgrade.pressed.connect(_attempt_buy_upgrade.bind(upgrade))
	next_level.pressed.connect(_next_level_button_pressed)
	
	
func _on_upgrade_button_hovered(button : UpgradeButton):
	if button.disabled:
		item_description.hide()
		return
	item_description.show()
	item_description.text = "%s [br] [color=green]%s$[/color]"%[button.current_upgrade.upgrade_text, button.current_upgrade.cost]
	
func _on_upgrade_button_unhovered():
	item_description.hide()
	
func _attempt_buy_upgrade(button : UpgradeButton):
	if button.can_buy_upgrade():
		button.buy_upgarde()
		fx_player.pitch_scale = randf_range(0.8,1.2)
		fx_player.play()
		print("Bought upgrade")
		_on_upgrade_button_hovered(button)
	else:
		print("can't buy!")
		
func _next_level_button_pressed():
	print("hiding")
	hide()
	get_tree().paused = false
	LevelManager.spawn_level()
