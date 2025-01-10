class_name DepthLight
extends PointLight2D

var depth_image: Image

func load_depth_image(depth_map: Texture2D):
	depth_image = depth_map.get_image()
	
func calculate_energy(base:= 0.4, exp:=2.0, scalar:=3.0):
	if not depth_image:
		return 0.0
		
	var x = global_position.x / 1280 * depth_image.get_width()
	var y = global_position.y / 720 * depth_image.get_height()
	
	x = clamp(x, 0, depth_image.get_width() - 1)
	y = clamp(y, 0, depth_image.get_height() - 1)
	return base + depth_image.get_pixel(x, y).get_luminance() ** exp * scalar
