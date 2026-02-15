extends CharacterBody2D
class_name Ball

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
		on_collision(collision_info)
			
func on_collision(collision_info : KinematicCollision2D):
	var normal = collision_info.get_normal()
	direction = direction.bounce(normal).normalized()
	$Sprite2D.scale = Vector2(abs(normal.y) + 1, abs(normal.x) + 1).normalized()
	print(normal)
	var collider = collision_info.get_collider()
	if collider.has_method("take_damage_player"):
		collider.take_damage_player(speed)
		

	if collider.has_meta("bounce_multiplier"):
		speed *= collider.get_meta("bounce_multiplier")
	if speed > max_speed:
		speed = max_speed
			
func take_damage_enemy(damage : float):
	print("%s took %s damage" %[name,damage])
	current_health -= damage
	if current_health <= 0:
		on_death()
		
func on_death():
	queue_free()
		
	
	
	
