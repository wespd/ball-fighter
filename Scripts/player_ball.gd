extends Ball

signal player_death
const PLAYER_DEATH = preload("uid://cl58wttmev3sr")
@export var starting_speed = 100.0

func on_death():
	get_tree().paused = true
	is_stunned = true
	sprite_2d.visible = false
	var death_anim := PLAYER_DEATH.instantiate()
	get_tree().current_scene.add_child(death_anim)
	death_anim.position = position
	await death_anim.animation_finished
	is_stunned = false
	sprite_2d.visible = true
	player_death.emit()
	print("Player died")

func on_collision(collision_info : KinematicCollision2D):
	CollisionManager.play_ran_into_something()
	var money_to_add := 0.2
	
	var normal = collision_info.get_normal()
	
	direction = direction.bounce(normal).normalized()
	
	var collider = collision_info.get_collider()
	if collider is Ball:
		CollisionManager.try_collision(self, collider)
	if collider.has_meta("bounce_multiplier"):
		speed *= collider.get_meta("bounce_multiplier")
		for child in collider.get_children(true):
			if child is AnimatedSprite2D:
				money_to_add += 0.8
				child.play("default")
	if speed > max_speed:
		speed = max_speed
	UpgradeGlobals.get_money(money_to_add, position)
		
