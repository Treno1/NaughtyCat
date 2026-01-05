extends AnimationPlayer
class_name LevelAnimator

signal system_ready

@onready var door: DoorAnimatedSprite = $"../Door"
@onready var owners_message: Node2D = $"../Door/OwnersMessage"
@onready var owners_message_text: Label = $"../Door/OwnersMessage/OwnersMessageText"
@onready var cloud: Sprite2D = $"../Door/OwnersMessage/Cloud"

var _level_data: LevelData
var _active = true

func _ready() -> void:
	GameManager.set_level_animator(self)
	emit_signal("system_ready")

var _active_mess_id = -1
var _active_timer : SceneTreeTimer = null

func show_next_message() -> void:
	_active_mess_id += 1
	if _level_data.owners_messages.size() <= _active_mess_id and _active:
		_continue_level_start()
		return
	await set_label_text(_level_data.owners_messages[_active_mess_id])
	
	if _level_data.owners_messages.size() > _active_mess_id and _active:
		_active_timer = get_tree().create_timer(_level_data.messages_timeout[_active_mess_id])

func _process(_delta: float) -> void:
	if _active_timer != null and _active:
		if _active_timer.time_left <= 0 or Input.is_action_just_pressed("jump"):
			show_next_message()

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
	owners_message.visible = true
	show_next_message()
	
func _continue_level_start():
	_active = false
	owners_message.visible = false
	door.close()
	await get_tree().create_timer(0.5).timeout
	GameManager.show_start_menu()
	#play("level_start")
