extends VehicleBody3D

signal checkpoint_entered(checkpoint_index: int)

@export var max_steer = 0.8
@export var engine_power = 500
@export var max_speed = 30

func _physics_process(delta: float) -> void:
	steering = move_toward(
		steering,
		Input.get_axis("turn_right", "turn_left") * max_steer,
		delta * 2.5
	)
	engine_force = Input.get_axis("move_backward", "move_forward") * engine_power

func _integrate_forces(state):
	var velocity = state.get_linear_velocity()
	# Limit the vehicle's speed
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
		state.set_linear_velocity(velocity)

func _on_checkpoint_entered(area: Area3D) -> void:
	checkpoint_entered.emit(area)
