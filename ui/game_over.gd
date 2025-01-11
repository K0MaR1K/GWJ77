extends Control

var restart_enabled := false

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart") and restart_enabled:
		get_tree().change_scene_to_file.call_deferred("res://main_scene.tscn")


func _process(delta: float) -> void:
	if Engine.get_process_frames() % 50 == 0:
		$RichTextLabel.visible = not $RichTextLabel.visible


func _on_player_game_over() -> void:
	restart_enabled = true
	show()
