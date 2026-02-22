extends CanvasLayer

@onready var money_label = $ColorRect/VBoxContainer/MoneyLabel
@onready var kills_label = $ColorRect/VBoxContainer/KillsLabel
@onready var round_status_label = $ColorRect/VBoxContainer/RoundStatusLabel
@onready var continue_button = $ColorRect/VBoxContainer/ContinueButton

@onready var audio_stream_player = $AudioStreamPlayer

func _ready():
	continue_button.pressed.connect(_continue_button_pressed)

func appear(round_won : bool):
	show()
	money_label.text = "Money Earned: [br][color=green]%s$" %UpgradeGlobals.money_this_round
	kills_label.text = "Enemies Killed: [br][color=red]%s" %UpgradeGlobals.kills_this_round
	if round_won:
		round_status_label.text = "Round [color=green]won!"
	else:
		round_status_label.text = "Round [color=red]Lost."


func _continue_button_pressed():
	audio_stream_player.play()
	print("continue button pressed")
	hide()
	UpgradeMenu.show()
