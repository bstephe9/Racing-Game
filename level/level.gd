extends Node3D

const MAX_LAPS: int = 3

@onready var NUM_CHECKPOINTS: int = $Checkpoints.get_children().size()

func _enter_tree() -> void:
	GameManager.current_level = self

func debug() -> void:
	$Debug/L_car.text = "Pos: %s | Rot: %s" % [
		$Vehicle.position,
		$Vehicle.rotation
	]

func update_hud() -> void:
	#$HUD/Lap.text = "Lap: %d/%d" % [current_lap, MAX_LAPS]
	pass
