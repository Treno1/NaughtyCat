extends CanvasLayer
class_name IngameUI

signal system_ready

@onready var timer: Timer = $CountdownLabel/Timer
@onready var countdown_label: Label = $CountdownLabel

func set_timer(total_seconds: int) -> void:
	timer.wait_time = total_seconds
	countdown_label.text = _get_time_str(total_seconds)

func start_timer(total_seconds: int = -1) -> void:
	if total_seconds > 0:
		timer.start(total_seconds)
	else:
		timer.start()

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
	
