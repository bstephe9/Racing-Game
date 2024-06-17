class_name Vehicle
extends VehicleBody3D

signal lap_complete

const PITCH_MIN: float = 1.0
const PITCH_MAX: float = 1.4
const ENGINE_MIN_PLAY: float = 1.5

var current_level
var current_lap: int = 1
var current_checkpoint: int

var velocity: Vector3
var pitch_effect = AudioServer.get_bus_effect(1, 0)
@export var max_steer = 0.8
@export var engine_power = 500
@export var max_speed = 50

func _enter_tree() -> void:
	current_level = GameManager.current_level

func _physics_process(delta: float) -> void:
	# Make engine play sound only when vehicle reaches a certain speed
	if velocity.length() > ENGINE_MIN_PLAY and velocity.y > -1: # TODO Use a tween
		play_engine_sound()
	else:
		$EngineSound.stop()

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	velocity = state.linear_velocity
	
	# Limit the vehicle's speed
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	
	state.linear_velocity = velocity

func _on_checkpoint_entered(checkpoint: Area3D) -> void:
	var checkpoint_index = \
		current_level.get_node("Checkpoints/" + str(checkpoint.name)).get_index()
	
	# Check if checkpoint or lap should be updated
	if checkpoint_index == 0: # Start line
		if current_checkpoint == current_level.NUM_CHECKPOINTS - 1:
			new_lap()
	elif abs(checkpoint_index - current_checkpoint) == 1: # Adjacent checkpoint
		current_checkpoint = checkpoint_index

func new_lap() -> void:
	current_checkpoint = 0
	if current_lap < current_level.MAX_LAPS:
		current_lap += 1
	else:
		pass # Race over

func play_engine_sound() -> void:
	# Alter engine sound pitch depending on velocity, constrained between 
	# PITCH_MIN and PITCH_MAX
	pitch_effect.pitch_scale = \
		(velocity.length() / max_speed) * (PITCH_MAX - PITCH_MIN) + PITCH_MIN
	
	$EngineSound.play()
