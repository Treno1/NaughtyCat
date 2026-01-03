extends Area2D
class_name Interactable

func _on_body_entered(body: Node2D) -> void:
	if body != Game.player:
		return
		
	Game.player.add_interactable(self)


func _on_body_exited(body: Node2D) -> void:
	if body != Game.player:
		return
		
	Game.player.remove_interactable(self)
	

func interact() -> void:
	return
