extends Node2D

@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_scene($CorridorScene)
	

func set_scene(scene: Node2D):
	camera.global_position = scene.global_position
	FlashLight.load_depth_image(scene.get_node("DepthMap").texture)

func _input(event: InputEvent) -> void:
	if event.is_action("ui_accept"):
		set_scene($CommonRoomScene)
