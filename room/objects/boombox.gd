extends TextureRect

var top_y : float = 63
var bottom_y : float = 197

var dragging_mix:=false
var dragging_music:=false
var dragging_sfx:=false

func move_knob_to_mouse(knob: TextureRect):
	knob.global_position.y = clamp(get_global_mouse_position().y-20, top_y, bottom_y)


func _on_music_knob_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		dragging_music = true
	if event.is_action_released("shoot"):
		dragging_music = false
		
	if dragging_music:
		move_knob_to_mouse($MusicKnob)

func _on_sfx_knob_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		dragging_sfx = true
	if event.is_action_released("shoot"):
		dragging_sfx = false
		
	if dragging_sfx:
		move_knob_to_mouse($SfxKnob)


func _on_mix_knob_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		dragging_mix = true
	if event.is_action_released("shoot"):
		dragging_mix = false
		
	if dragging_mix:
		move_knob_to_mouse($MixKnob)

#HACK: suuuper bad fix but works 
func _on_back_button_pressed() -> void:
	$"../../../../ObjectHandler".set_mouse_input(false)
	for child in $"..".get_children():
		child.hide()
