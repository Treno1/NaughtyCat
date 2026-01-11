extends Control
class_name LevelStartMenu

signal system_ready

@onready var task_1_label: Label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer3/Task1Label
@onready var task_2_label: Label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer4/Task2Label
@onready var task_3_label: Label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer5/Task3Label
@onready var task_4_label: Label = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer6/Task4Label

@onready var labels := [
	task_1_label,
	task_2_label,
	task_3_label,
	task_4_label
]

func _ready() -> void:
	GameManager.set_lvl_start_ui(self)
	emit_signal("system_ready")
	$AnimationPlayer.play("RESET")
	hide()
	
func show_start_menu(level_data: LevelData):
	# tasks text goes here
	var id = 0
	for task in level_data.tasks:
		if id >= labels.size():
			break
		labels[id].text = "* " + task.task_ui_text
		id += 1
		
	for i in range(labels.size() - id):
		labels[id + i].text = ""
		
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")


func _on_button_pressed() -> void:
	$AnimationPlayer.play_backwards("blur")
	await get_tree().create_timer(0.15).timeout
	hide()
	get_tree().paused = false
	GameManager.start_menu_finished()

func _process(_delta: float) -> void:
	if !visible:
		return
	if Input.is_action_just_pressed("enter") || Input.is_action_just_pressed("jump"):
		_on_button_pressed()
