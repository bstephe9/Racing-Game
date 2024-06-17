extends Vehicle

var input_turn: float
var input_move: float

var actions = {
	"move_forward":"move_forward",
	"move_backward":"move_backward",
	"turn_left":"turn_left",
	"turn_right":"turn_right",
}

func _ready() -> void:
	# To spawn the vehicle in the correct location in 3D viewport
	top_level = true
	max_steer = 0.8
	engine_power = 500
	max_speed = 50

func _unhandled_input(event: InputEvent) -> void:
	input_turn = Input.get_axis(actions["turn_right"], actions["turn_left"])
	input_move = Input.get_axis(actions["move_backward"], actions["move_forward"])

func _physics_process(delta: float) -> void:
	super(delta)
	steering = move_toward(steering, input_turn * max_steer, delta * 5.0)
	engine_force = input_move * engine_power

func new_lap() -> void:
	super()
	lap_complete.emit(current_lap)

func _on_hud_countdown_finished(params) -> void:
	for action in params:
		Global.enable_input(actions, action)
