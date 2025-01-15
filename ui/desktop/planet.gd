@tool

extends Sprite2D

func _process(_delta: float) -> void:
	if Engine.get_process_frames() % 10 == 0:
		frame = (frame + 1) % (hframes * vframes)
