extends Node

var _total_pending := 4
var pending := _total_pending
var _player: CatPlayer = null
var _ingame_ui: IngameUI = null
var _level_data: LevelData = null
var _lvl_finish_ui: LevelFinishMenu = null

var _task_trackers: Array[TaskTracker]
var _tasks_left := 0
	
func restart_level() -> void:
	pending = _total_pending
	get_tree().reload_current_scene()	
	
func next_level() -> void:
	restart_level()

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
	_lvl_finish_ui.finish_level()
	
func timeout():
	_lvl_finish_ui.lose_level()
	
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
	
func set_lvl_finish_ui(lvl_finish_ui: LevelFinishMenu) -> void:
	_lvl_finish_ui = lvl_finish_ui
	_lvl_finish_ui.system_ready.connect(_on_system_ready)
	
	
func start_play() -> void:
	# Setup tasks
	_setup_task_trackers()
	
	# Give controls to player
	_player.set_state_normal()
	
	# Start timer
	_ingame_ui.start_timer()
	
	
	
