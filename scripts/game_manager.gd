extends Node

const LEVELS := [
	preload("res://scenes/lvl0.tscn"),
	preload("res://scenes/lvl1.tscn"),
	preload("res://scenes/lvl1_old.tscn"),
	preload("res://scenes/lvl2_old.tscn")
	]
	
enum GameState { MAIN_MENU, PLAY, PAUSE, LEVEL_END }

@onready var level_finish_sounds: Node = $LevelFinishSounds

var game_state := GameState.MAIN_MENU

var red_timer_seconds := 5

var _total_pending := 6
var pending := _total_pending
var _player: CatPlayer = null
var _ingame_ui: IngameUI = null
var _level_data: LevelData = null
var _lvl_start_ui: LevelStartMenu = null
var _lvl_finish_ui: LevelFinishMenu = null
var _level_animator: LevelAnimator = null

#region DI
func set_player(player: CatPlayer) -> void:
	_player = player
	_player.system_ready.connect(_on_system_ready)
	
func set_ingame_ui(ingame_ui: IngameUI) -> void:
	_ingame_ui = ingame_ui
	_ingame_ui.system_ready.connect(_on_system_ready)
	
func set_level_animator(level_animator: LevelAnimator) -> void:
	_level_animator = level_animator
	_level_animator.system_ready.connect(_on_system_ready)
	
func set_level_data(level_data: LevelData) -> void:
	_level_data = level_data
	_level_data.system_ready.connect(_on_system_ready)
	
func set_lvl_start_ui(lvl_start_ui: LevelStartMenu) -> void:
	_lvl_start_ui = lvl_start_ui
	_lvl_start_ui.system_ready.connect(_on_system_ready)
	
func set_lvl_finish_ui(lvl_finish_ui: LevelFinishMenu) -> void:
	_lvl_finish_ui = lvl_finish_ui
	_lvl_finish_ui.system_ready.connect(_on_system_ready)
#endregion

var _task_trackers: Array[TaskTracker]
var _tasks_left := 0

var _lvl_id := 1
var _max_lvl := LEVELS.size()
	
func restart_level() -> void:
	pending = _total_pending
	get_tree().reload_current_scene()	
	
func next_level() -> void:
	pending = _total_pending
	_lvl_id += 1
	if _lvl_id > _max_lvl:
		_lvl_id = 1
	
	get_tree().change_scene_to_packed(LEVELS[_lvl_id-1])
	
	await get_tree().scene_changed
	game_state = GameState.PLAY

func _on_system_ready() -> void:
	pending -= 1
	if pending != 0:
		return
	
	if !_is_in_level():
		return
		
	_ingame_ui.set_timer(_level_data.timer_limit_seconds)
	
	# for debug reasons
	start_play()
	
func _setup_task_trackers():
	_task_trackers = []
	_tasks_left = 0
	
	await get_tree().process_frame
	
	for task in _level_data.tasks:
		var tracker = TaskTracker.new()
		get_tree().current_scene.add_child.call_deferred(tracker)
		tracker.setup.call_deferred(task)
		_task_trackers.append(tracker)
		_tasks_left += 1
		
	await get_tree().process_frame
	
	_ingame_ui.add_tasks(_task_trackers)
	
	for tracker in _task_trackers:
		tracker.task_completed.connect(_on_task_completed)
		
func _on_task_completed(task_tracker: TaskTracker):
	_tasks_left -= 1
	print("tasks left: ", _tasks_left, ", completed task: ", task_tracker._task_data.task_ui_text)
	if _tasks_left <= 0:
		_level_complete()
	
func _level_complete():
	var sound = level_finish_sounds.get_children().pick_random() as AudioStreamPlayer2D
	sound.play()
	game_state = GameState.LEVEL_END
	_lvl_finish_ui.finish_level()
	
func timeout():
	game_state = GameState.LEVEL_END
	_lvl_finish_ui.lose_level()
	
func pre_timeout():
	print("pre_timeout")
	_level_animator.pre_timer_trigger()
	
func _is_in_level():
	return _level_data != null and GameState.PLAY
	
	
func start_play() -> void:
	# Setup tasks
	_setup_task_trackers()
	
	_ingame_ui.visible = false
	
	_player.set_state_cutscene()
	
	# Show owners messages and close the door
	await _level_animator.level_start(_level_data)
	
func show_start_menu() -> void: 
	if _lvl_start_ui != null:
		_lvl_start_ui.show_start_menu(_level_data)

func start_menu_finished() -> void:
	_lvl_start_ui.queue_free()
	
	# Start timer
	_ingame_ui.visible = true
	_ingame_ui.start_timer()
	
	# Give controls to player
	_player.set_state_normal()
	
	
	game_state = GameState.PLAY
	
