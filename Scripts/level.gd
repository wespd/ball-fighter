extends Node2D
class_name Level

@export var balls: Array[Ball]
signal player_won

func _ready():
	PlayerBall.player_death.connect(_on_player_death)
	for ball in balls:
		ball.died.connect(on_ball_death.bind(ball))
	
func _on_player_death():
	get_tree().paused = true
	UpgradeMenu.show()
	
func on_ball_death(ball : Ball):
	balls.erase(ball)
	if balls.is_empty():
		player_won.emit()
