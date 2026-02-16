extends CharacterBody2D
class_name Ball

const DIMENSIONS : Vector2 = Vector2(360,360)

@export var speed : float = 300
@export var max_speed : float = 1000
@export var max_health : float = 4000
@export var damage_multiplier : float = 1.0
@onready var sprite_2d = $Sprite2D
var is_stunned : bool = false
var is_first_frame : bool = true
var current_health : float
var direction : Vector2 = Vector2(1,3)
signal died
const ENEMY_DEATH = preload("uid://c51bs6ef7pdb6")

func _ready():
	current_health = max_health
	direction = Vector2.from_angle(randf_range(0,2 * PI))
	velocity = direction.normalized() * speed
	
func _process(delta):
	if is_first_frame:
		is_first_frame = false
		return
	var motion = direction * speed * delta * (0 if is_stunned else 1)
	var collision_info = move_and_collide(motion)
	
	if collision_info:
		on_collision(collision_info)
	_warp_ball()
			
func bounce_off_surface(normal : Vector2):
	direction = direction.bounce(normal).normalized()

func on_collision(collision_info : KinematicCollision2D):
	var normal = collision_info.get_normal()
	direction = direction.bounce(normal).normalized()
	var collider = collision_info.get_collider()
	
	if collider == PlayerBall:
		CollisionManager.try_collision(self, collider)

	if collider.has_meta("bounce_multiplier"):
		speed *= collider.get_meta("bounce_multiplier")
		for child in collider.get_children(true):
			if child is AnimatedSprite2D:
				child.play("default")
			
	if speed > max_speed:
		speed = max_speed
			

func take_damage(damage : float):
	print("%s took %s damage" %[name,damage])
	current_health -= damage
	if current_health <= 0:
		on_death()
		
func on_death():
	sprite_2d.visible = false
	died.emit()
	var death_anim = ENEMY_DEATH.instantiate()
	get_tree().current_scene.add_child(death_anim)
	death_anim.position = position
	UpgradeGlobals.get_money(5.0, position)
	queue_free()
	
func _warp_ball():
	if position.x < -DIMENSIONS.x/2:
		position.x = DIMENSIONS.x/2
	if position.x > DIMENSIONS.x/2:
		position.x = -DIMENSIONS.x/2
	if position.y < -DIMENSIONS.y/2:
		position.y = DIMENSIONS.y/2
	if position.y > DIMENSIONS.y/2:
		position.y = -DIMENSIONS.y/2
	
		
	
	
	
