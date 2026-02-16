extends Node

var collisions : Dictionary[Ball,Ball] = {}

	
func try_collision(this : Ball, other : Ball):
	print(collisions)
	if collisions.has(this) and collisions.get(this) == other:
		return
	if not other.is_stunned:
		this.take_damage(other.speed * other.damage_multiplier)
	if not this.is_stunned:
		other.take_damage(this.speed * this.damage_multiplier)
	other.bounce_off_surface((other.position - this.position).normalized())
	collisions.get_or_add(other, this)

func play_ran_into_something():
	for key in collisions.keys():
		if not key == PlayerBall:
			collisions.clear()
