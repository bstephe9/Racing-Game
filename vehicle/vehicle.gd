extends VehicleBody3D

@export var max_steer = 0.8
@export var engine_power = 500
@export var max_speed = 30

func _physics_process(delta: float) -> void:
	steering = move_toward(
		steering,
		Input.get_axis("turn_right", "turn_left") * max_steer,
		delta * 2.5
	)
	engine_force = Input.get_axis("none", "move_forward") * engine_power

func _integrate_forces(state):
	var velocity = state.get_linear_velocity()
	# Limit the vehicle's speed
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
		state.set_linear_velocity(velocity)
