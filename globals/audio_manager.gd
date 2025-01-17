extends Node2D

var instance: AudioStreamPlayer
var instance2D: AudioStreamPlayer2D

@onready var shooter_player: AudioStreamPlayer = $ShooterPlayer
@onready var shooter_player_2: AudioStreamPlayer = $ShooterPlayer2
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func pitch_scale_up():
	if shooter_player:
		var tween = get_tree().create_tween()
		tween.tween_property(shooter_player, "pitch_scale", 1.0, 1.0)
		
func pitch_scale_down(): 
	if shooter_player:
		var tween = get_tree().create_tween()
		tween.tween_property(shooter_player, "pitch_scale", 0.7, 1.0)

func start_music():
	shooter_player_2.play()

func shift_shooter21():
	if shooter_player_2:
		shooter_player.play(shooter_player_2.get_playback_position())
	animation_player.play.call_deferred("shift_shooter_2-1")
	
func shift_shooter12():
	animation_player.play("shift_shooter_1-2")

func music_fade():
	if shooter_player:
		var tween = get_tree().create_tween()
		tween.tween_property(shooter_player, "volume_db", -80, 1.0)

func play_sound(stream: AudioStream, volume: float, bus: StringName):
	instance = AudioStreamPlayer.new()
	instance.stream = stream
	instance.volume_db = volume
	instance.bus = bus
	add_child(instance)
	instance.play()
	instance.finished.connect(remove_stream.bind(instance))
	
func play_sound_2d(stream: AudioStream, volume: float, bus: StringName, position: Vector2):
	instance2D = AudioStreamPlayer2D.new()
	instance2D.global_position = position
	instance2D.stream = stream
	instance2D.volume_db = volume
	instance2D.bus = bus
	add_child(instance2D)
	instance2D.play()
	instance2D.finished.connect(remove_stream.bind(instance2D))
	
func remove_stream(inst):
	inst.queue_free()
	
