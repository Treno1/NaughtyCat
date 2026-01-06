extends Area2D
class_name Interacter


var interactableAreas := []
var interactableBodies := []

@onready var interact_sprite: AnimatedSprite2D = $".."

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	var interactable = area as Interactable
	if !interactable:
		return
		
	if !interactable.enabled:
		return
		
	if !interactableAreas.has(interactable):
		interactableAreas.append(interactable)
		
	interact_sprite.visible = true

func _on_area_shape_exited(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	var interactable = area as Interactable
	if !interactable:
		return
		
	interactableAreas.erase(interactable)
	
	if interactableAreas.is_empty() and interactableBodies.is_empty():
		interact_sprite.visible = false


func _on_body_entered(body: Node2D) -> void:
	var interactable = body as InteractableBody
	if !interactable:
		return
		
	if !interactable.enabled:
		return
		
	if !interactableBodies.has(interactable):
		interactableBodies.append(interactable)
		
	interact_sprite.visible = true


func _on_body_exited(body: Node2D) -> void:
	var interactable = body as InteractableBody
	if !interactable:
		return
		
	interactableBodies.erase(interactable)
	
	if interactableAreas.is_empty() and interactableBodies.is_empty():
		interact_sprite.visible = false

		
func interact() -> void:
	if !interactableAreas.is_empty():
		interactableAreas[0].interact()
		return
	
	if !interactableBodies.is_empty():
		interactableBodies[0].interact()
		return
		
	
