extends Area2D

var current_ball : Ball
@onready var timer = $Timer

func _ready():
	body_entered.connect(_on_ball_entered)
	timer.timeout.connect(release_ball)
	
func _on_ball_entered(ball : Ball):
	if not ball or current_ball:
		return
	current_ball = ball
	ball.is_stunned = true
	var tweener := get_tree().create_tween()
	tweener.tween_property(ball, "position", position, 0.4)
	timer.start(3.0)
	
	
func release_ball():
	if current_ball:
		current_ball.is_stunned = false
	current_ball = null
