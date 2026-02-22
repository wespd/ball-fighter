extends CanvasLayer

@onready var button = $VBoxContainer/Button
@onready var audio_stream_player = $AudioStreamPlayer

func _ready():
	button.pressed.connect(_on_start_button_pressed)
	
func _on_start_button_pressed():
	audio_stream_player.play()
	UpgradeMenu.show()
