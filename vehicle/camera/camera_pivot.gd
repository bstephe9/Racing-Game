extends Node3D

@onready var parent = self.owner

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("look_behind"):
		$RearCamera.make_current()
	else:
		$ForwardCamera.make_current()

func _physics_process(delta: float) -> void:
	global_position = global_position.lerp(parent.global_position, delta * 20.0)
	transform = transform.interpolate_with(parent.transform, delta * 5.0)
