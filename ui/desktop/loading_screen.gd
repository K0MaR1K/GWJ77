extends Control

@export var load_stream_happy : AudioStream
@export var load_stream_sad : AudioStream
@export var load_stream_mysterious : AudioStream
@export var error_stream : AudioStream

@onready var underscore: Label = $Control/Underscore
@onready var loading_audio: AudioStreamPlayer = $LoadingAudio
@onready var line_edit: LineEdit = $LoginScreen/LineEdit


func _ready() -> void:
	if PhaseManager.computer_on:
		hide()
	else:
		match PhaseManager.loading_jingle:
			
			PhaseManager.LDJ.HAPPY:
				loading_audio.stream = load_stream_happy
			PhaseManager.LDJ.SAD:
				loading_audio.stream = load_stream_sad
			PhaseManager.LDJ.MYSTERIOUS:
				loading_audio.stream = load_stream_mysterious
				
		$LoadingAnimation.play("load")
		PhaseManager.computer_on = true

func login_screen():
	if PhaseManager.current_phase == PhaseManager.Phase.INTRO and Global.player_name == "Gregor":
		$LoadingAnimation.pause()
		$LoginScreen.show()

	
func _process(_delta: float) -> void:
	if Engine.get_process_frames() % 20 == 0:
		underscore.visible = not underscore.visible

func start_music():
	AudioManager.start_music()


func _on_submit_pressed() -> void:
	_on_line_edit_text_submitted($LoginScreen/LineEdit.text)


func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text.length() > 0:
		Global.player_name = new_text
		$LoadingAnimation.play()
		$LoginScreen.hide()
	else:
		AudioManager.play_sound(error_stream, 0, "SFX")
		var line = $LoginScreen/LineEdit
		line.scale = Vector2(1.2, 1.2)
		var tween = get_tree().create_tween()
		tween.tween_property(line, "scale", Vector2(1.0, 1.0), 0.3)
