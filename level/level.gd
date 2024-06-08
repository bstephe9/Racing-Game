extends Node3D

const MAX_LAPS: int = 3

var current_lap: int = 1

func _process(delta: float) -> void:
	update_ui()

func debug() -> void:
	$Debug/L_car.text = "Pos: %s | Rot: %s" % [
		$Vehicle.position,
		$Vehicle.rotation
	]

func update_ui() -> void:
	$UI/Lap.text = "Lap: %d/%d" % [current_lap, MAX_LAPS]

func _on_start_line_body_entered(body: Node3D) -> void:
	current_lap += 1
