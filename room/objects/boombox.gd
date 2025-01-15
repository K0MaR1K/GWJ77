extends TextureRect

var top_y : float = 63
var bottom_y : float = 197

var max_db : float= 0.0
var min_db : float= -50.0

var dragging_mix:=false
var dragging_music:=false
var dragging_sfx:=false

func _ready() -> void:
	move_knob_to_position($MixKnob, lerp(bottom_y, top_y, (AudioServer.get_bus_volume_db(0) - min_db) / (max_db - min_db)))
	move_knob_to_position($SfxKnob, lerp(bottom_y, top_y, (AudioServer.get_bus_volume_db(2) - min_db) / (max_db - min_db)))
	move_knob_to_position($MusicKnob, lerp(bottom_y, top_y, (AudioServer.get_bus_volume_db(1) - min_db) / (max_db - min_db)))

func move_knob_to_position(knob: TextureRect, pos: float):
	knob.global_position.y = clamp(pos, top_y, bottom_y)


func _on_music_knob_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		dragging_music = true
	if event.is_action_released("shoot"):
		dragging_music = false
		
	if dragging_music:
		move_knob_to_position($MusicKnob, get_global_mouse_position().y-20)
		AudioServer.set_bus_volume_db(1, lerp(max_db, min_db, ($MusicKnob.global_position.y - top_y) / (bottom_y - top_y)))

func _on_sfx_knob_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		dragging_sfx = true
	if event.is_action_released("shoot"):
		dragging_sfx = false
		
	if dragging_sfx:
		move_knob_to_position($SfxKnob, get_global_mouse_position().y-20)
		AudioServer.set_bus_volume_db(2, lerp(max_db, min_db, ($SfxKnob.global_position.y - top_y) / (bottom_y - top_y)))

func _on_mix_knob_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		dragging_mix = true
	if event.is_action_released("shoot"):
		dragging_mix = false
		
	if dragging_mix:
		move_knob_to_position($MixKnob,get_global_mouse_position().y-20)
		AudioServer.set_bus_volume_db(0, lerp(max_db, min_db, ($MixKnob.global_position.y - top_y) / (bottom_y - top_y)))

#HACK: suuuper bad fix but works 
func _on_back_button_pressed() -> void:
	$"../../../../ObjectHandler".set_mouse_input(false)
	for child in $"..".get_children():
		child.hide()


func _on_test_sound_pressed() -> void:
	$TestSoundAudio.play()
