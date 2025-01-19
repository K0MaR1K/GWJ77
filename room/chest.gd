extends Node

const KEY = preload("res://resources/key/key.tres")
const MATCHES = preload("res://resources/matches/matches.tres")
@onready var object_handler: Node3D = $"../../../../../ObjectHandler"

func send_item(item: Item):
	if item == KEY:
		Global.add_to_inventory(MATCHES)
		PhaseManager.chest = false


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action("shoot") and object_handler.close_up and PhaseManager.chest:
		Global.request_item(KEY, self)
