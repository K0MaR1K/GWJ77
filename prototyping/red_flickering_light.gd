@tool
class_name RedFlickeringLight
extends DepthLight

@export_range(0.4, 10.0, 0.2) var base_energy := 1.0

var _t := 0.0

func _ready() -> void:
	load_depth_image($"../DepthMap".texture)
	base_energy = calculate_energy(0.2, 2.0, 2.0)

func _process(delta: float) -> void:
	_t += delta * 10.0
	energy = base_energy + sin(_t) * base_energy
