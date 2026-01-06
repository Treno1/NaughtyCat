extends Control

func _ready() -> void:
	$AnimationPlayer.play("RESET")
	hide()

func resume():
	GameManager.game_state = GameManager.GameState.PLAY
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	GameManager.game_state = GameManager.GameState.PAUSE
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
	resume()


func _on_restart_pressed() -> void:
	resume()
	GameManager.restart_level()


func _process(_delta: float) -> void:
	if GameManager.game_state != GameManager.GameState.PLAY and !visible:
		return
	test_esc()
