extends Resource
class_name BaseUpgrade

@export var modifiers : Dictionary[String, float]
@export var upgrade_text : String
@export var cost : float = 999

func apply_upgrade():
	# 1. Check if the variable exists to prevent a crash
	for mod in modifiers:
		if mod in PlayerBall:
			# 2. Get the current value of the variable
			var current_value = PlayerBall.get(mod)
			
			# 3. Calculate the new value (Current + Upgrade Amount)
			var new_value = current_value + modifiers.get(mod)
			
			# 4. Set the new value back to the variable
			PlayerBall.set(mod, new_value)
			
			print("Upgraded ", mod, " to ", new_value)
		else:
			printerr("Error: Variable '", mod, "' not found on PlayerBall.")
