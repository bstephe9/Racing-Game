extends VehicleBody3D

signal checkpoint_entered(checkpoint_index: int)

const PITCH_MIN: float = 1.0
const PITCH_MAX: float = 1.4
const ENGINE_MIN_PLAY: float = 1.5

var velocity: Vector3
var pitch_effect = AudioServer.get_bus_effect(1, 0)
@export var max_steer = 0.8
@export var engine_power = 500
@export var max_speed = 50

func _physics_process(delta: float) -> void:
	steering = move_toward(
		steering,
		Input.get_axis("turn_right", "turn_left") * max_steer,
		delta * 5.0
	)
	engine_force = Input.get_axis("move_backward", "move_forward") * engine_power
	
	# Make engine play sound only when vehicle reaches a certain speed
	if velocity.length() > ENGINE_MIN_PLAY: # TODO Use a tween
		play_engine_sound()
	else:
		$EngineSound.stop()

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	velocity = state.linear_velocity
	
	# Limit the vehicle's speed
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	
	state.linear_velocity = velocity

func _on_checkpoint_entered(area: Area3D) -> void:
	checkpoint_entered.emit(area)

func play_engine_sound() -> void:
	# Alter engine sound pitch depending on velocity, constrained between 
	# PITCH_MIN and PITCH_MAX
	pitch_effect.pitch_scale = \
		(velocity.length() / max_speed) * (PITCH_MAX - PITCH_MIN) + PITCH_MIN
	
	$EngineSound.play()
