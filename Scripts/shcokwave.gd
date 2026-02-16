extends CanvasLayer

@onready var color_rect = $ColorRect

# Shader parameters
var force: float = 0.0
var size: float = 0.0
var max_size: float = 0.1 # How big the circle gets
var duration: float = 0.5 # How long the effect lasts

func _ready():
	# Start the animation
	var tween = create_tween()
	# Animate size from 0 to max_size
	tween.parallel().tween_method(set_shader_size, 0.0, max_size, duration)
	# Animate force (strength) fading out
	tween.parallel().tween_method(set_shader_force, 0.05, 0.0, duration)
	# Delete the node when done
	tween.tween_callback(queue_free)

func start(global_pos: Vector2):
	# Convert world position to screen position (0.0 to 1.0 range)
	var screen_transform = get_viewport().get_canvas_transform()
	var screen_pos = screen_transform * global_pos
	
	# Normalize the position (x: 0-1, y: 0-1)
	var normalized_center = screen_pos / get_viewport().get_visible_rect().size
	
	color_rect.material.set_shader_parameter("center", normalized_center)
	# Set static thickness
	color_rect.material.set_shader_parameter("thickness", 0.05)

# Helper to set shader params via Tween
func set_shader_size(value: float):
	color_rect.material.set_shader_parameter("size", value)

func set_shader_force(value: float):
	color_rect.material.set_shader_parameter("force", value)
