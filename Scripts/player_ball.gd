extends Ball

signal player_death

func on_death():
	player_death.emit()
	print("Player died")

func on_collision(collision_info : KinematicCollision2D):
	var normal = collision_info.get_normal()
	
	direction = direction.bounce(normal).normalized()
	
	var collider = collision_info.get_collider()
	if collider.has_method("take_damage_enemy"):
		collider.take_damage_enemy(speed)
		

	if collider.has_meta("bounce_multiplier"):
		speed *= collider.get_meta("bounce_multiplier")
	if speed > max_speed:
		speed = max_speed
		
func take_damage_enemy(damage : float):
	pass
	
func take_damage_player(damage : float):
	super.take_damage_enemy(damage)
