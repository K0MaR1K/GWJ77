extends Control

@onready var underscore: Label = $Control/Underscore
@onready var loading_audio: AudioStreamPlayer = $LoadingAudio

func _ready() -> void:
	if PhaseManager.computer_on:
		hide()
	else:
		match PhaseManager.loading_jingle:
			
			PhaseManager.LDJ.HAPPY:
				loading_audio.stream = load("res://sounds/load_1.wav")
			PhaseManager.LDJ.SAD:
				loading_audio.stream = load("res://sounds/load_2.wav")
			PhaseManager.LDJ.MYSTERIOUS:
				loading_audio.stream = load("res://sounds/load_3.wav")
				
		$LoadingAnimation.play("load")
		PhaseManager.computer_on = true

func _process(_delta: float) -> void:
	if Engine.get_process_frames() % 20 == 0:
		underscore.visible = not underscore.visible
