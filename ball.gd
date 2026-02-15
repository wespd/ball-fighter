extends CharacterBody2D

@export var speed : float
@export var max_speed : float = 2000
var direction : Vector2 = Vector2(1,3)

func _ready():
	velocity = direction.normalized() * speed
	
func _process(delta):
	var motion = direction * speed * delta
	var collision_info = move_and_collide(motion)
	
	if collision_info:
		var normal = collision_info.get_normal()
		
		direction = direction.bounce(normal).normalized()
		
		speed *= 1.1
		if speed > max_speed:
			speed = max_speed
		
	
	
	
