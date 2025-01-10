@tool
extends DepthLight

var _t := 0.0

func _process(delta: float) -> void:
	_t += delta * 2.0
	global_position = get_global_mouse_position()
	global_position += Vector2(10, 0) * sin(_t) +  Vector2(0, 20) * cos(_t) ** 2
	energy = calculate_energy()
	#material.set_shader_param("")
