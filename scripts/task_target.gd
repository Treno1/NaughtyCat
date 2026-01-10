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
	var parent := get_parent()
	if parent == null:
		return []

	var interactables = _get_interactables_from_children(parent.get_children(true))
		
	return interactables

func _get_interactables_from_children(children : Array[Node]) -> Array[Interactable]:
	var interactables: Array[Interactable] = []
	for child in children:
		var interactable = child as Interactable
		if interactable:
			interactables.append(interactable)
		
		if child.get_child_count(true) <= 0:
			continue
			
		var subInteractables = _get_interactables_from_children(child.get_children())
		if subInteractables.size() > 0:
			interactables.append_array(subInteractables)
			
	return interactables

func _on_interactable_complete():
	inters_finished += 1
	
	if inters_finished >= inters_total:
		emit_signal("task_completed")
