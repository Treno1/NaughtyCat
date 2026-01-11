extends Control
class_name LevelFinishMenu

enum LevelFinishResult { WIN, FAIL }

signal system_ready

@onready var label: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var button: Button = $PanelContainer/MarginContainer/VBoxContainer/Button

@export var win_text: String = "Level Complete!"
@export var win_button_text: String = "Next Level"
@export var win_text_color: Color = Color.ALICE_BLUE
@export var lose_text: String = "Time's out!"
@export var lose_button_text: String = "Restart"
@export var lose_text_color: Color = Color.DARK_RED

var _state : LevelFinishResult = LevelFinishResult.FAIL

func _ready() -> void:
	GameManager.set_lvl_finish_ui(self)
	emit_signal("system_ready")
	$AnimationPlayer.play("RESET")
	hide()
	
func finish_level():
	_enable(LevelFinishResult.WIN)
	
func lose_level():
	_enable(LevelFinishResult.FAIL)

func _enable(state: LevelFinishResult):
	_state = state
	if _state == LevelFinishResult.WIN:
		label.text = win_text
		label.add_theme_color_override("font_color", win_text_color)
		button.text = "\n" + win_button_text + "\n\n"
	elif _state == LevelFinishResult.FAIL:
		label.text = lose_text
		label.add_theme_color_override("font_color", lose_text_color)
		button.text = "\n" + lose_button_text + "\n\n"
		
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")


func _on_button_pressed() -> void:
	get_tree().paused = false
	if _state == LevelFinishResult.FAIL:
		GameManager.restart_level()
	else:
		GameManager.next_level()

func _process(_delta: float) -> void:
	if !visible:
		return
	if Input.is_action_just_pressed("enter") || Input.is_action_just_pressed("jump"):
		_on_button_pressed()
