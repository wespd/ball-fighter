extends CanvasLayer

@export var upgrades : Array[UpgradeButton]
@onready var item_description_background = $ItemDescriptionBackground
@onready var item_description = $ItemDescriptionBackground/ItemDescription
@onready var next_level = $NextLevel

func _ready():
	hide()
	for upgrade in upgrades:
		upgrade.mouse_entered.connect(_on_upgrade_button_hovered.bind(upgrade))
		upgrade.mouse_exited.connect(_on_upgrade_button_unhovered)
		upgrade.pressed.connect(_attempt_buy_upgrade.bind(upgrade))
	next_level.pressed.connect(_next_level_button_pressed)
	
	
func _on_upgrade_button_hovered(button : UpgradeButton):
	if button.disabled:
		return
	item_description_background.show()
	item_description.text = "%s [br] [color=green]%s$[/color]"%[button.current_upgrade.upgrade_text, button.current_upgrade.cost]
	
func _on_upgrade_button_unhovered():
	item_description_background.hide()
	
func _attempt_buy_upgrade(button : UpgradeButton):
	if button.can_buy_upgrade():
		button.buy_upgarde()
		print("Bought upgrade")
		print(PlayerBall.max_speed)
		if button.disabled:
			item_description_background.hide()
	else:
		print("can't buy!")
		
func _next_level_button_pressed():
	print("hiding")
	hide()
	LevelManager.spawn_level()
