extends Area2D
class_name Interacter


var interactables := []

@onready var interact_sprite: AnimatedSprite2D = $".."

func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	var interactable = area as Interactable
	if !interactable:
		return
		
	if !interactable.enabled:
		return
		
	if !interactables.has(interactable):
		interactables.append(interactable)
		
	interact_sprite.visible = true

func _on_area_shape_exited(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	var interactable = area as Interactable
	if !interactable:
		return
		
	interactables.erase(interactable)
	
	if interactables.is_empty():
		interact_sprite.visible = false
		
func interact() -> void:
	if interactables.is_empty():
		return
		
	interactables[0].interact()
