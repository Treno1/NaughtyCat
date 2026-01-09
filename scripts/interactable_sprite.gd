extends Interactable

@export var target_sprite: Sprite2D = null

var completed := false

func interact() -> void:
	if target_sprite == null:
		return
	
	target_sprite.visible = !target_sprite.visible
	
	if !completed:
		complete_interaction()
		completed = true
	
