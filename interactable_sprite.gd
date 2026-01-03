extends Interactable
class_name InteractableSprite

@export var target_sprite: Sprite2D = null

func interact() -> void:
	if target_sprite == null:
		return
	
	target_sprite.visible = !target_sprite.visible
	
