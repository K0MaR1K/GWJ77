extends Camera2D


func _process(_delta: float) -> void:
	global_position = (get_viewport_rect().size / 2 * 9 + get_global_mouse_position()) / 10
