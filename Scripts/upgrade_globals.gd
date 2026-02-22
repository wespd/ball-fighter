extends Node

const MONEY_UP = preload("uid://cji2nyfbdyjvq")

var money : float = 0.0

var money_this_round = 0
var kills_this_round = 0

func get_money(amount : float, location : Vector2):
	var money_sprite = MONEY_UP.instantiate()
	money_sprite.amount = amount
	money_sprite.position = location
	get_tree().current_scene.add_child(money_sprite)

func _ready():
	LevelManager.level_starting.connect(reset_trackers)
	
func reset_trackers():
	money_this_round = 0
	kills_this_round = 0
