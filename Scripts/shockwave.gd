extends ColorRect

func emit_shockwave():
	var tweener = get_tree().create_tween()
	tweener.tween_method(change_force, 0.0, 1.0, 0.2)
	tweener.tween_method(change_force, 1.0, 0.0, 0.2)
	
func change_force(value : float):
	if material is ShaderMaterial:
		material.set_shader_parameter("force", value)
