extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body != Game.player:
		return
		
	Game.player.add_landing(self.get_instance_id())


func _on_body_exited(body: Node2D) -> void:
	if body != Game.player:
		return
		
	Game.player.remove_landing(self.get_instance_id())
