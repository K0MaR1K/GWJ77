extends SubViewportContainer


func _on_play_button_pressed() -> void:
	print("aaaa")
	get_tree().change_scene_to_file.call_deferred("res://viewport.tscn")

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		$SubViewport.push_input(event)
