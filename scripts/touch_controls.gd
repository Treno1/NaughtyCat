extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !OS.has_feature("mobile") and !OS.has_feature("web_android") and !OS.has_feature("web_ios"):
	#if false:
		visible = false


func _on_fullscreen_pressed() -> void:
	var mode = DisplayServer.window_get_mode()
	if mode == DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN or mode == DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
