extends Control

@onready var underscore: Label = $Control/Underscore

func _process(_delta: float) -> void:
	if Engine.get_process_frames() % 20 == 0:
		underscore.visible = not underscore.visible
