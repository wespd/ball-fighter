extends TextureButton
class_name UpgradeButton

@export var upgrade_description : String = ""
@export var upgrades : Array[BaseUpgrade]
@export var linked_buttons : Array[UpgradeButton]
var current_upgrade : BaseUpgrade
var current_index : int = 0

func _ready():
	for button in linked_buttons:
		button.hide()
	if not upgrades.is_empty():
		current_upgrade = upgrades[0]
	else:
		push_error("Upgrades not given to upgrade button")
		
func can_buy_upgrade():
	if not disabled:
		if UpgradeGlobals.money >= current_upgrade.cost:
			return true
	return false

func buy_upgarde():
	if not can_buy_upgrade():
		push_error("Tried to buy upgarde without the funds!")
		return
	current_upgrade.apply_upgrade()
	UpgradeGlobals.money -= current_upgrade.cost
	current_index += 1
	if current_index < upgrades.size():
		current_upgrade = upgrades[current_index]
	else:
		print("Upgrade ran out!")
		disabled = true
	for button in linked_buttons:
		button.show()
	
