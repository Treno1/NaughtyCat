extends Area2D
class_name Interactable

@export var target_sprite: Sprite2D = null

func _on_body_entered(body: Node2D) -> void:
	if body != Game.player:
		return
		
	Game.player.add_interactable(self)


func _on_body_exited(body: Node2D) -> void:
	if body != Game.player:
		return
		
	Game.player.remove_interactable(self)
	

func interact() -> void:
	if target_sprite == null:
		return
	
	target_sprite.visible = !target_sprite.visible
