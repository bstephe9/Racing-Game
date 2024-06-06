extends Node

func _ready() -> void:
	capture_mouse()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"): get_tree().quit()
	if Input.is_action_just_pressed("mouse_capture"):
		release_mouse() if Global.mouse_captured else capture_mouse()

func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.mouse_captured = true

func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Global.mouse_captured = false
