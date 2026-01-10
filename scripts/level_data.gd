extends Node
class_name LevelData

signal system_ready

@export_multiline var owners_messages: Array[String] = []
@export var messages_timeout: Array[int] = []
@export var timer_limit_seconds: int = 120

var tasks: Array[TaskData] = []

func _ready() -> void:
	for node in get_children():
		var taskData = node as TaskData
		if taskData != null:
			tasks.append(taskData)
	GameManager.set_level_data(self)
	emit_signal("system_ready")
