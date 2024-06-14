extends CanvasLayer

func _ready() -> void:
	$Lap.text = "Lap: 1/%d" % [GameManager.current_level.MAX_LAPS]

func _on_player_lap_complete(current_lap: int) -> void:
	$Lap.text = "Lap: %d/%d" % [current_lap, GameManager.current_level.MAX_LAPS]
