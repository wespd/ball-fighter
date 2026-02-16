extends ColorRect

@onready var money_label = $VBoxContainer/MoneyLabel
@onready var kills_label = $VBoxContainer/KillsLabel
@onready var round_status_label = $VBoxContainer/RoundStatusLabel
@onready var continue_button = $VBoxContainer/ContinueButton

func appear():
	show()
	
