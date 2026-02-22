extends CharacterBody2D
class_name Ball

const DIMENSIONS : Vector2 = Vector2(360,360)

const ON_HIT_DAMAGE = preload("uid://yd7btfw7mn6e")


@export var speed : float = 300
@export var max_speed : float = 1000
@export var max_health : float = 4000
@export var damage_multiplier : float = 1.0
@onready var sprite_2d = $Sprite2D
var is_stunned : bool = false
var is_first_frame : bool = true
var current_health : float
var direction : Vector2 = Vector2(1,3)
var is_hovered_by_mouse : bool = false
signal died
const ENEMY_DEATH = preload("uid://c51bs6ef7pdb6")

func _ready():
	current_health = max_health
	direction = Vector2.from_angle(randf_range(0,2 * PI))
	velocity = direction.normalized() * speed
	mouse_entered.connect(_on_hover)
	mouse_exited.connect(_on_hover_released)
	
func _on_hover():
	is_hovered_by_mouse = true
	
func _on_hover_released():
	is_hovered_by_mouse = false

func _process(delta):
	if is_first_frame:
		is_first_frame = false
		return
	var motion = direction * speed * delta * (0 if is_stunned else 1)
	var collision_info = move_and_collide(motion)
	
	if is_hovered_by_mouse and Input.is_action_just_pressed("left_click"):
		take_damage(PlayerBall.click_damage)
	
	if collision_info:
		on_collision(collision_info)
			
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
	var damage_effect = ON_HIT_DAMAGE.instantiate()
	add_child(damage_effect)
	damage_effect.emitting = true
	damage_effect.finished.connect(destroy_effect.bind(damage_effect))
	current_health -= damage
	UpgradeGlobals.get_money(int(damage) / 10.0, position)
	if current_health <= 0:
		on_death()
		
func destroy_effect(effect):
	effect.queue_free()
		
func on_death():
	sprite_2d.visible = false
	UpgradeGlobals.kills_this_round += 1
	died.emit()
	var death_anim = ENEMY_DEATH.instantiate()
	get_tree().current_scene.add_child(death_anim)
	death_anim.position = position
	
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
	
		
	
	
	
