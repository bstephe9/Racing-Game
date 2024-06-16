extends CanvasLayer

func _ready() -> void:
	$Lap.text = "Lap: 1/%d" % [GameManager.current_level.MAX_LAPS]

func _process(delta: float) -> void:
	if $CountdownTimer.time_left != 0:
		$Countdown.text = str(ceil($CountdownTimer.time_left))

func _on_player_lap_complete(current_lap: int) -> void:
	$Lap.text = "Lap: %d/%d" % [current_lap, GameManager.current_level.MAX_LAPS]

func countdown() -> void:
	$CountdownTimer.start()

func _on_countdown_timer_timeout() -> void:
	$Countdown.text = "GO!"
	await get_tree().create_timer(1.0).timeout
	$Countdown.hide()
