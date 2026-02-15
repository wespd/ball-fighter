extends Node2D

func _ready():
	PlayerBall.player_death.connect(_on_player_death)
	
func _on_player_death():
	get_tree().paused = true
