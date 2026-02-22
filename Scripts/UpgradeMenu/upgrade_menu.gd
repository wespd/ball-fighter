extends CanvasLayer

@onready var item_description = $ItemDescription
@onready var next_level = $NextLevel
@onready var fx_player = $FXPlayer
const UPGRADE = preload("uid://o6knacpw3rt1")
const CLICK = preload("uid://c0x52pq83dcxr")
const CANT_PURCHASE = preload("uid://ckpsl88cegmyr")

func _ready():
	hide()
	for upgrade in get_children():
		if upgrade is UpgradeButton:
			upgrade.mouse_entered.connect(_on_upgrade_button_hovered.bind(upgrade))
			upgrade.mouse_exited.connect(_on_upgrade_button_unhovered)
			upgrade.pressed.connect(_attempt_buy_upgrade.bind(upgrade))
	next_level.pressed.connect(_next_level_button_pressed)
	
	
func _on_upgrade_button_hovered(button : UpgradeButton):
	if button.disabled:
		item_description.hide()
		return
	item_description.show()
	item_description.text = "%s [br] [color=green]%s$[/color]"%[button.current_upgrade.upgrade_text, button.current_upgrade.cost]
	
func _on_upgrade_button_unhovered():
	item_description.hide()
	
func _attempt_buy_upgrade(button : UpgradeButton):
	if button.can_buy_upgrade():
		button.buy_upgarde()
		fx_player.volume_db = 0.0
		fx_player.stream = UPGRADE
		fx_player.pitch_scale = randf_range(0.8,1.2)
		fx_player.play()
		print("Bought upgrade")
		_on_upgrade_button_hovered(button)
	else:
		var tweener := get_tree().create_tween()
		tweener.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		button.modulate = Color(1.0, 0.398, 0.329, 1.0)
		tweener.tween_property(button, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.2)
		print("can't buy!")
		fx_player.volume_db = -10.0
		fx_player.stream = CANT_PURCHASE
		fx_player.pitch_scale = randf_range(0.8,1.2)
		fx_player.play()

func _next_level_button_pressed():
	
	fx_player.volume_db = 10.0
	fx_player.stream = CLICK
	fx_player.pitch_scale = randf_range(0.8,1.2)
	fx_player.play()
	Transition.transition()
	await Transition.transition_hidden
	print("hiding")
	hide()
	get_tree().paused = false
	
	LevelManager.spawn_level()
