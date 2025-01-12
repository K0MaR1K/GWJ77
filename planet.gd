@tool

extends Sprite2D

func _process(delta: float) -> void:
	if Engine.get_process_frames() % 10 == 0:
		frame = (frame + 1) % (hframes * vframes)
