extends Ball

signal player_death
const PLAYER_DEATH = preload("uid://cl58wttmev3sr")


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
	var normal = collision_info.get_normal()
	
	direction = direction.bounce(normal).normalized()
	
	var collider = collision_info.get_collider()
	if collider is Ball:
		CollisionManager.try_collision(self, collider)
	if collider.has_meta("bounce_multiplier"):
		speed *= collider.get_meta("bounce_multiplier")
		for child in collider.get_children(true):
			if child is AnimatedSprite2D:
				child.play("default")
	if speed > max_speed:
		speed = max_speed
		
