extends Control

func _ready() -> void:
	$AnimationPlayer.play("RESET")
	hide()

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func test_esc():
	if !Input.is_action_just_pressed("esc"):
		return
		
	if get_tree().paused == false:
		pause()
	else:
		resume()


func _on_resume_pressed() -> void:
	print("resume pressed")
	resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _process(_delta: float) -> void:
	test_esc()
