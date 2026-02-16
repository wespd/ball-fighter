extends Node

var current_level : int = 0

var levels : Array[String] = [
	"res://Scenes/main.tscn"
]

func spawn_level():
	PlayerBall.global_position = Vector2.ZERO
	PlayerBall.current_health = PlayerBall.max_health
	PlayerBall.direction = Vector2.from_angle(randf_range(0,2 * PI))
	PlayerBall.is_stunned = false
	print(get_tree().current_scene.scene_file_path)
	if get_tree().current_scene.scene_file_path == levels[current_level]:
		get_tree().reload_current_scene()
		print("Current scene reloaded")
		await get_tree().scene_changed
	else:
		get_tree().change_scene_to_file(levels[current_level])
		await get_tree().scene_changed
	get_tree().current_scene.player_won.connect(on_player_won)
	get_tree().paused = false
	PlayerBall.current_health = PlayerBall.max_health
	
func on_player_won():
	get_tree().paused = true
	print("PLAYER HATH WON")
	
