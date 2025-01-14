class_name Pointer
extends Sprite2D

@export var base_pointer: Texture
@export var select_pointer: Texture

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_base_pointer()
	
func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
	if Engine.get_process_frames() % 5 == 0:
		frame = (frame + 1) % hframes

func set_base_pointer():
	texture = base_pointer
	
func set_select_pointer():
	texture = select_pointer
