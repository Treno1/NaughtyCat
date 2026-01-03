extends Area2D
class_name Interactable

signal interaction_complete

func interact() -> void:
	return
	
func complete_interaction() -> void:
	emit_signal("interaction_complete")
