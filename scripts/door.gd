extends AnimatedSprite2D
class_name DoorAnimatedSprite

func opened() -> void:
	play("opened")

func open() -> void:
	play("open")
	
func close() -> void:
	play_backwards("open")
