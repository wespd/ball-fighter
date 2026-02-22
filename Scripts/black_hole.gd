extends Node2D

func _process(delta):
	if Input.is_action_pressed("right_click"):
		global_position = get_global_mouse_position()
