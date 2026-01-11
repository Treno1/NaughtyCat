extends Control
class_name TaskUI

@onready var task_label: Label = $TaskLabel
@onready var task_progress_bar: ProgressBar = $TaskProgressBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(task_data: TaskData) -> void:
	task_label.text = "* " + task_data.task_ui_text
	task_progress_bar.value = 0
	
func complete(_task_tracker: TaskTracker) -> void:
	animation_player.play("complete")
