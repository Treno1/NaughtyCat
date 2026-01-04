extends AnimationPlayer
class_name LevelAnimator

signal system_ready

@onready var door: DoorAnimatedSprite = $"../Door"

func _ready() -> void:
	GameManager.set_level_animator(self)
	emit_signal("system_ready")

func pre_timer_trigger():
	play("timer_out")
	door.open()
