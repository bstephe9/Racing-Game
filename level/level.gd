extends Node3D

const MAX_LAPS: int = 3

@onready var NUM_CHECKPOINTS: int = $Checkpoints.get_children().size()

func _enter_tree() -> void:
	GameManager.current_level = self

func _ready() -> void:
	$HUD.countdown()

func debug() -> void:
	$Debug/L_car.text = "Pos: %s | Rot: %s" % [
		$Vehicle.position,
		$Vehicle.rotation
	]
