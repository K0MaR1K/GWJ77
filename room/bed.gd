extends StaticBody3D

const PVC_PIPE = preload("res://resources/pvc_pipe/pvc_pipe.tres")

@onready var object_handler: Node3D = $".."

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed("shoot") and not object_handler.close_up:
		if PhaseManager.pvc_pipe:
			Global.add_to_inventory(PVC_PIPE)
			PhaseManager.pvc_pipe = false
		else:
			GlobalSpeech.speak("What could this be made out of?")
	
