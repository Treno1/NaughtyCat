extends Node2D
class_name InteractableTaskTarget

signal task_completed


var inters_finished := 0
var inters_total := 0

func _ready() -> void:
	for interactable in get_interactables_from_parent():
		interactable.interaction_complete.connect(_on_interactable_complete)
		inters_total += 1
	
func get_interactables_from_parent() -> Array[Interactable]:
	var siblings: Array[Interactable] = []
	var parent := get_parent()
	if parent == null:
		return siblings

	for child in parent.get_children():
		var interactable = child as Interactable
		if interactable:
			siblings.append(interactable)

	return siblings

func _on_interactable_complete():
	inters_finished += 1
	
	if inters_finished >= inters_total:
		emit_signal("task_completed")
