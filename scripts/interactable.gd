extends Area2D
class_name Interactable

signal interaction_complete

@export var enabled: bool = true

func interact() -> void:
	return
	
func complete_interaction() -> void:
	emit_signal("interaction_complete")
