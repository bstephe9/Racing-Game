extends Node3D

const MAX_LAPS: int = 3

var current_lap: int = 0
var current_checkpoint: int
var checkpoint_index: int
@onready var num_checkpoints: int = $Checkpoints.get_children().size()

func _ready() -> void:
	new_lap()

func _process(delta: float) -> void:
	debug()

func debug() -> void:
	$Debug/L_car.text = "Pos: %s | Rot: %s" % [
		$Vehicle.position,
		$Vehicle.rotation
	]
	$Debug/L_checkpoint.text = "Last: %s | Current: %s" % [
		checkpoint_index, current_checkpoint
	]

func update_hud() -> void:
	$HUD/Lap.text = "Lap: %d/%d" % [current_lap, MAX_LAPS]

func _on_checkpoint_entered(checkpoint: Area3D) -> void:
	checkpoint_index = $Checkpoints.get_node(str(checkpoint.name)).get_index()
	
	# Check if checkpoint or lap should be updated
	if checkpoint_index == 0: # Start line
		if current_checkpoint == num_checkpoints - 1:
			new_lap()
	elif abs(checkpoint_index - current_checkpoint) == 1: # Adjacent checkpoint
		current_checkpoint = checkpoint_index
	
func new_lap() -> void:
	current_checkpoint = 0
	if current_lap < MAX_LAPS:
		current_lap += 1
	else:
		pass # Race over
	update_hud() # TODO when timer is added, call this somewhere else
