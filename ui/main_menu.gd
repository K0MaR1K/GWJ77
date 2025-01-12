extends SubViewportContainer


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred("res://main_scene.tscn")
