extends CanvasLayer

@onready var button = $VBoxContainer/Button

func _ready():
	button.pressed.connect(_on_start_button_pressed)
	
func _on_start_button_pressed():
	UpgradeMenu.show()
