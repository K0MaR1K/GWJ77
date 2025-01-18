extends Control

var restart_enabled := false

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart") and restart_enabled:
		AudioManager.pitch_scale_up()
		get_tree().change_scene_to_file.call_deferred("res://arcade_game/main_scene.tscn")


func _process(_delta: float) -> void:
	if Engine.get_process_frames() % 50 == 0:
		$GameOverText.visible = not $GameOverText.visible


func _on_player_game_over() -> void:
	restart_enabled = true
	show()
	$GameOverText/YouDiedText.show()
	AudioManager.pitch_scale_down()

func _on_arcade_scene_time_out() -> void:
	restart_enabled = true
	show()
	$GameOverText/TimeOutText.show()

func start_over():
	PhaseManager.change_phase(PhaseManager.Phase.INTRO)
