extends Node3D

const MAX_LAPS: int = 3

@onready var NUM_CHECKPOINTS: int = $Checkpoints.get_children().size()
@onready var player: VehicleBody3D = $Racers/Player

func _enter_tree() -> void:
	GameManager.current_level = self

func _ready() -> void:
	Global.disable_input(player.actions, "move_forward")
	Global.disable_input(player.actions, "move_backward")
	$HUD.countdown()

func debug() -> void:
	$Debug/L_car.text = "Pos: %s | Rot: %s" % [
		$Vehicle.position,
		$Vehicle.rotation
	]
