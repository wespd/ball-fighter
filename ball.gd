extends CharacterBody2D

@export var speed : float = 300
@export var max_speed : float = 1000
@export var max_health : float = 4000
var current_health : float
var direction : Vector2 = Vector2(1,3)

func _ready():
	current_health = max_health
	direction = Vector2.from_angle(randf_range(0,2 * PI))
	velocity = direction.normalized() * speed
	
func _process(delta):
	var motion = direction * speed * delta
	var collision_info = move_and_collide(motion)
	
	if collision_info:
		var normal = collision_info.get_normal()
		
		direction = direction.bounce(normal).normalized()
		
		var collider = collision_info.get_collider()
		if collider.has_method("on_collision"):
			collider.on_collision(speed)
		if collider.has_meta("bounce_multiplier"):
			speed *= collider.get_meta("bounce_multiplier")
		if speed > max_speed:
			speed = max_speed
			
func on_collision(damage : float):
	print("%s took %s damage" %[name,damage])
	current_health -= damage
	if current_health <= 0:
		queue_free()
		
	
	
	
