extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body != GameManager.player:
		return
		
	GameManager.player.add_landing(self.get_instance_id())


func _on_body_exited(body: Node2D) -> void:
	if body != GameManager.player:
		return
		
	GameManager.player.remove_landing(self.get_instance_id())
