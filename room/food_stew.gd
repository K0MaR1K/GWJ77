extends StaticBody3D

const FORK = preload("res://resources/fork/fork.tres")


@onready var object_handler: Node3D = $".."


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action("shoot") and not object_handler.close_up:
		Global.request_item(FORK, self)

func send_item(item: Item):
	if item == FORK:
		Transitions.transition(Transitions.BLINK, Transitions.DISSOLVE)
