extends Resource
class_name BaseUpgrade

@export var amounts : Array[float]
@export var variables_to_modify : Array[String]
@export var upgrade_text : String
@export var cost : float = 999

func apply_upgrade():
	# 1. Check if the variable exists to prevent a crash
	for i in variables_to_modify.size():
		if variables_to_modify[i] in PlayerBall:
			# 2. Get the current value of the variable
			var current_value = PlayerBall.get(variables_to_modify[i])
			
			# 3. Calculate the new value (Current + Upgrade Amount)
			var new_value = current_value + amounts[i]
			
			# 4. Set the new value back to the variable
			PlayerBall.set(variables_to_modify[i], new_value)
			
			print("Upgraded ", variables_to_modify[i], " to ", new_value)
		else:
			printerr("Error: Variable '", variables_to_modify[i], "' not found on PlayerBall.")
