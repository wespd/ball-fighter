extends Node2D
class_name Level

var balls: Array[Ball]
signal player_won

func _ready():
	for child in get_children():
		if child is Ball:
			child.died.connect(on_ball_death.bind(child))
			balls.append(child)
	
func on_ball_death(ball : Ball):
	balls.erase(ball)
	if balls.is_empty():
		print("player won!")
		get_tree().paused = true
		player_won.emit()
