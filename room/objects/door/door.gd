extends TextureRect

@export var knock_sound: AudioStream
@export var opening_sound: AudioStream

var t = 0.0

func _ready() -> void:
	GlobalSpeech.finished_speech.connect(end_speech)

func _process(delta: float) -> void:
	t += delta
	if t > 6 and PhaseManager.mother_at_door and not GlobalSpeech.monologue:
		t = 0
		AudioManager.play_sound(knock_sound, 5, "SFX")

func cutscene():
	show()
	if not GlobalSpeech.monologue:
		
		if PhaseManager.current_phase == PhaseManager.Phase.ROOM1_1:
			GlobalSpeech.mother_speech(GlobalSpeech.mother_speech_1)
		elif PhaseManager.current_phase == PhaseManager.Phase.ROOM2_1:
			GlobalSpeech.mother_speech(GlobalSpeech.mother_speech_2)
			
		$AnimationPlayer.play("open")

func play_sound_open():
	AudioManager.play_sound(opening_sound, 5, "SFX")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name != "close":
		$AnimationPlayer.play("loop")

func end_speech():
	$AnimationPlayer.play("close")
	PhaseManager.next_phase()
	$"../../../..".update()
