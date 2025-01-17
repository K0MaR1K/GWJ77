extends Control

@export var load_stream_happy : AudioStream
@export var load_stream_sad : AudioStream
@export var load_stream_mysterious : AudioStream

@onready var underscore: Label = $Control/Underscore
@onready var loading_audio: AudioStreamPlayer = $LoadingAudio


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

func _process(_delta: float) -> void:
	if Engine.get_process_frames() % 20 == 0:
		underscore.visible = not underscore.visible

func start_music():
	AudioManager.start_music()
