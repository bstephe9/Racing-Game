extends Vehicle

func _ready() -> void:
	max_steer = 0.8
	engine_power = 0
	max_speed = 50

func _physics_process(delta: float) -> void:
	super(delta)
	engine_force = engine_power
