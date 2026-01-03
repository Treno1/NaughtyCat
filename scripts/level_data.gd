extends Node
class_name LevelData

signal system_ready

@export var tasks: Array[TaskData] = []
@export var timer_limit_seconds: int = 120


func _ready() -> void:
	GameManager.set_level_data(self)
	emit_signal("system_ready")
