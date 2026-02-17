extends Node

var current_level : int = 0

var levels : Array[String] = [
	"res://Scenes/Levels/first_level.tscn",
	"res://Scenes/Levels/second_level.tscn"
]

signal level_starting

func _ready():
	PlayerBall.player_death.connect(on_player_loss)

func spawn_level():
	level_starting.emit()
	PlayerBall.global_position = Vector2.ZERO
	PlayerBall.current_health = PlayerBall.max_health
	PlayerBall.direction = Vector2.from_angle(randf_range(0,2 * PI))
	PlayerBall.speed = PlayerBall.starting_speed
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
	
	
func next_level():
	current_level += 1
	if current_level >= levels.size():
		get_tree().paused = true
		print("PLAYER BEAT GAME")

func on_player_won():
	RoundOverBox.appear(true)
	next_level()
	print("player won level")
	

func on_player_loss():
	print("showing box!")
	RoundOverBox.appear(false)
