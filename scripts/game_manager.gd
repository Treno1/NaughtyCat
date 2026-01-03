extends Node

var pending := 2
var _player: CatPlayer = null
var _ingame_ui: IngameUI = null

@export var is_in_level: bool = false
@export var time_limit_seconds: int = 0


func _on_system_ready() -> void:
	pending -= 1
	if pending != 0:
		return
	
	await get_tree().current_scene.ready
	
	if !is_in_level:
		return
		
	_ingame_ui.set_timer(time_limit_seconds)
	
	# for debug reasons
	start_play()
	
func set_player(player: CatPlayer) -> void:
	_player = player
	_player.system_ready.connect(_on_system_ready)
	
func set_ingame_ui(ingame_ui: IngameUI) -> void:
	_ingame_ui = ingame_ui
	_ingame_ui.system_ready.connect(_on_system_ready)
	
	
func start_play() -> void:
	# Give controls to player
	_player.set_state_normal()
	
	# Start timer
	_ingame_ui.start_timer()
	
	
	
