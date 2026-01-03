extends Node

var pending := 3
var _player: CatPlayer = null
var _ingame_ui: IngameUI = null
var _level_data: LevelData = null

func _on_system_ready() -> void:
	pending -= 1
	if pending != 0:
		return
	
	if !_is_in_level():
		return
		
	_ingame_ui.set_timer(_level_data.timer_limit_seconds)
	
	# for debug reasons
	start_play()
	
func _is_in_level():
	return _level_data != null
	
func set_player(player: CatPlayer) -> void:
	_player = player
	_player.system_ready.connect(_on_system_ready)
	
func set_ingame_ui(ingame_ui: IngameUI) -> void:
	_ingame_ui = ingame_ui
	_ingame_ui.system_ready.connect(_on_system_ready)
	
func set_level_data(level_data: LevelData) -> void:
	_level_data = level_data
	_level_data.system_ready.connect(_on_system_ready)
	
	
func start_play() -> void:
	# Give controls to player
	_player.set_state_normal()
	
	# Start timer
	_ingame_ui.start_timer()
	
	
	
