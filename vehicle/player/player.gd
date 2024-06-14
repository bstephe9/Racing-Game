extends Vehicle

func _ready() -> void:
	super()
	max_steer = 0.8
	engine_power = 500
	max_speed = 50

func _physics_process(delta: float) -> void:
	super(delta)
	steering = move_toward(
		steering,
		Input.get_axis("turn_right", "turn_left") * max_steer,
		delta * 5.0
	)
	engine_force = Input.get_axis("move_backward", "move_forward") * engine_power
