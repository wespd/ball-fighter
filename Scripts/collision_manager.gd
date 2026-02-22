extends Node

var collisions : Dictionary[Ball,Ball] = {}

	
func try_collision(this : Ball, other : Ball):
	if collisions.has(this) and collisions.get(this) == other:
		return
	if not other.is_stunned:
		var damage = (other.speed * other.damage_multiplier) if other != PlayerBall else ((other.speed * other.speed_damage_multiplier + other.base_damage) * other.damage_multiplier)
		this.take_damage(damage)
	if not this.is_stunned:
		var damage = (this.speed * this.damage_multiplier) if this != PlayerBall else ((this.speed * this.speed_damage_multiplier + this.base_damage) * this.damage_multiplier)
		other.take_damage(damage)
	other.bounce_off_surface((other.position - this.position).normalized())
	collisions.get_or_add(other, this)

func play_ran_into_something():
	for key in collisions.keys():
		if not key == PlayerBall:
			collisions.clear()
