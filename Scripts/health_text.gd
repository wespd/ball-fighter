extends RichTextLabel
class_name DebugHealthText

var ball : Ball

func _ready():
	ball = get_parent()
	
func _process(delta):
	clear()
	append_text("%s/%s" %[int(ball.current_health), int(ball.max_health)])
