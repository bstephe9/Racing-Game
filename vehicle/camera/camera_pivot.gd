extends Node3D

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("look_behind"):
		$RearCamera.make_current()
	else:
		$ForwardCamera.make_current()
