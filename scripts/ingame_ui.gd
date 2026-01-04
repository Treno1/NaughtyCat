extends CanvasLayer
class_name IngameUI

signal system_ready

@onready var timer: Timer = $CountdownLabel/Timer
@onready var countdown_label: Label = $CountdownLabel
@onready var tasks_container: GridContainer = $MarginContainer/GridContainer
var TaskControl := preload("res://scenes/task_control.tscn")
var tasksControls: Array[TaskUI] = []

func set_timer(total_seconds: int) -> void:
	timer.wait_time = total_seconds
	countdown_label.text = _get_time_str(total_seconds)

func add_tasks(task_trackers: Array[TaskTracker]) -> void:
	for tracker in task_trackers:
		var control = TaskControl.instantiate()
		tasks_container.add_child(control)
		tasksControls.append(control)
		
	await get_tree().process_frame
	
	for i in range(tasksControls.size()):
		tasksControls[i].setup(task_trackers[i]._task_data)
		task_trackers[i].task_completed.connect(tasksControls[i].complete)
	

func start_timer(total_seconds: int = -1) -> void:
	if total_seconds > 0:
		timer.start(total_seconds)
	else:
		timer.start()
	
	timer.timeout.connect(GameManager.timeout)

func _ready() -> void:
	GameManager.set_ingame_ui(self)
	emit_signal("system_ready")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if timer:
		countdown_label.text = _get_time_str(timer.time_left)


func _get_time_str(time: float) -> String:
	var minutes = time / 60 as int
	var seconds = int(time) % 60 as int
	
	return str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
	
