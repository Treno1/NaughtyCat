extends Control

const LVL1 = preload("res://scenes/lvl0.tscn")
#const LVL1 = preload("res://scenes/lvl1.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(LVL1)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("enter") || Input.is_action_just_pressed("jump"):
		_on_button_pressed()
