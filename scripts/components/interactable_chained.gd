extends Interactable
class_name InteractableChained

@export var oneShot := true
@export var downchainInteractables : Array[Interactable] = []

func interact() -> void:
	super.interact()
	if oneShot:
		complete_interaction()
	

func complete_interaction() -> void:
	super.complete_interaction()
