extends Node

var mouse_captured: bool = false

func disable_input(action_dict: Dictionary, key: String):
	if InputMap.has_action(key):
		action_dict[key] = "none"

func enable_input(action_dict: Dictionary, key: String):
	if InputMap.has_action(key):
		action_dict[key] = key
