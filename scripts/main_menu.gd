extends Control

var start_lvl_id = 2

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(GameManager.LEVELS[start_lvl_id])

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("enter") || Input.is_action_just_pressed("jump"):
		_on_button_pressed()
