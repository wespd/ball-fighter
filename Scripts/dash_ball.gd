extends Ball

@onready var dash_duration = $DashDuration
@onready var dash_trigger = $DashTrigger

var is_dashing : bool = false

func _ready():
	super._ready()
	dash_trigger.timeout.connect(start_dashing)
	dash_duration.timeout.connect(stop_dashing)
	
func start_dashing():
	is_dashing = true
	direction = position.direction_to(PlayerBall.position).normalized()
	dash_duration.start()
	
func stop_dashing():
	is_dashing = false
	dash_trigger.start()
	speed *= 1.1
	if speed > max_speed:
		speed = max_speed

func on_collision(collision_info : KinematicCollision2D):
	var normal = collision_info.get_normal()
	direction = direction.bounce(normal).normalized()
	var collider = collision_info.get_collider()
	audio_stream_player.volume_db = -10
	audio_stream_player.pitch_scale = randf_range(0.6,1.4)
	audio_stream_player.stream = BLIP
	audio_stream_player.play()
	
	if collider == PlayerBall:
		CollisionManager.try_collision(self, collider)

	if collider.has_meta("bounce_multiplier"):
		speed *= collider.get_meta("bounce_multiplier")
		for child in collider.get_children(true):
			if child is AnimatedSprite2D:
				child.play("default")
			
	if speed > max_speed:
		speed = max_speed

func _process(delta):
	if is_first_frame:
		is_first_frame = false
		return
	var motion = direction * speed * delta * (0 if is_stunned else 1)
	if is_dashing:
		motion = direction * max_speed * 2 * delta * (0 if is_stunned else 1)
	var collision_info = move_and_collide(motion)
	
	if is_hovered_by_mouse and Input.is_action_just_pressed("left_click"):
		take_damage(PlayerBall.click_damage)
		audio_stream_player.volume_db = 0
		audio_stream_player.pitch_scale = randf_range(0.6,1.4)
		audio_stream_player.stream = CLICK_DAMAGE
		audio_stream_player.play()
	
	if collision_info:
		on_collision(collision_info)
