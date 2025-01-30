extends SubViewportContainer

@export var click_sound : AudioStream

@onready var pointer: Pointer = $SubViewport/CanvasLayer/Pointer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		AudioManager.play_sound(click_sound, 37, "SFX")
	
	if event.is_action_pressed("back"):
		_on_power_button_pressed()

func _ready() -> void:
	GlobalSpeech.clear()
	for object: TextureButton in $SubViewport/CanvasLayer/VBoxContainer.get_children():
		object.mouse_entered.connect(_on_object_mouse_entered)
		object.mouse_exited.connect(_on_object_mouse_exited)
		
func _on_object_mouse_entered() -> void:
	pointer.set_select_pointer()


func _on_object_mouse_exited() -> void:
	pointer.set_base_pointer()


func _on_play_button_pressed() -> void:
	if PhaseManager.can_play_game:
		Transitions.transition(Transitions.DISSOLVE, Transitions.DISSOLVE)
	else:
		GlobalSpeech.speak("I could eat something.")


func _on_power_button_pressed() -> void:
	if PhaseManager.can_leave_computer:
		get_tree().change_scene_to_file.call_deferred("res://room/room_scene.tscn")
	else:
		GlobalSpeech.speak("Not now.")


func _on_leaderboard_button_pressed() -> void:
	$SubViewport/CanvasLayer/Leaderboard.show()


func _on_settings_button_pressed() -> void:
	GlobalSpeech.speak("Settings will be available later in the game by clicking the boombox. [shake]Sorry.")


func _on_video_play_button_pressed() -> void:
	$SubViewport/CanvasLayer/VideoStreamPlayer.play()
