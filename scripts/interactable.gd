extends Area2D
class_name Interactable

signal interaction_complete

@export var enabled: bool = true

const INTERACTABLE_LAYER = 4

func _ready() -> void:
	collision_layer = INTERACTABLE_LAYER
	collision_mask = 0

func interact() -> void:
	return
	
func complete_interaction() -> void:
	emit_signal("interaction_complete")
