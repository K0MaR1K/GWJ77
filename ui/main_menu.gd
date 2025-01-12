extends SubViewportContainer

@onready var pointer: Pointer = $SubViewport/CanvasLayer/Pointer

func _ready() -> void:
	for object: TextureButton in $SubViewport/CanvasLayer/VBoxContainer.get_children():
		object.mouse_entered.connect(_on_object_mouse_entered)
		object.mouse_exited.connect(_on_object_mouse_exited)
		
func _on_object_mouse_entered() -> void:
	pointer.set_select_pointer()


func _on_object_mouse_exited() -> void:
	pointer.set_base_pointer()


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred("res://arcade_game/main_scene.tscn")
