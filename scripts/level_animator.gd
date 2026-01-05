extends AnimationPlayer
class_name LevelAnimator

signal system_ready

@onready var door: DoorAnimatedSprite = $"../Door"
@onready var owners_message: Node2D = $"../Door/OwnersMessage"
@onready var owners_message_text: Label = $"../Door/OwnersMessage/OwnersMessageText"
@onready var cloud: Sprite2D = $"../Door/OwnersMessage/Cloud"

var _level_data: LevelData

func _ready() -> void:
	GameManager.set_level_animator(self)
	emit_signal("system_ready")

func show_messages() -> void:
	owners_message.visible = true
	for id in range(_level_data.owners_messages.size()):
		set_label_text(_level_data.owners_messages[id])
		await get_tree().create_timer(_level_data.messages_timeout[id]).timeout
	owners_message.visible = false
	

func set_label_text(text: String) -> void:
	owners_message_text.text = ""
	for c in text:
		owners_message_text.text += c
		await get_tree().create_timer(0.05).timeout

func pre_timer_trigger():
	play("timer_out")
	door.open()
	
func level_start(level_data: LevelData):
	_level_data = level_data
	door.opened()
	await show_messages()
	door.close()
	play("level_start")
