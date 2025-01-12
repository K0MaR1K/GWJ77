extends Node3D

@onready var pointer: Pointer = $"../CanvasLayer/Pointer"

func _ready() -> void:
	for object: StaticBody3D in get_children():
		object.mouse_entered.connect(_on_object_mouse_entered)
		object.mouse_exited.connect(_on_object_mouse_exited)

func _on_object_mouse_entered() -> void:
	pointer.set_select_pointer()


func _on_object_mouse_exited() -> void:
	pointer.set_base_pointer()


func _on_computer_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action("shoot"):
		get_tree().change_scene_to_file.call_deferred("res://ui/main_menu.tscn")
