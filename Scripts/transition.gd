extends CanvasLayer

@onready var animation_player = $AnimationPlayer

signal transition_complete
signal transition_hidden

func transition():
	animation_player.play("transition")
	print("Playing transition")
	await animation_player.animation_finished
	print("Transition finished")
	transition_hidden.emit()
	animation_player.play_backwards("transition")
	print("Playing backwards transition")
	await animation_player.animation_finished
	transition_complete.emit()
