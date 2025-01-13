extends Control

var next_level_enabled := false

func _process(_delta: float) -> void:
	if Engine.get_process_frames() % 50 == 0:
		$RichTextLabel.visible = not $RichTextLabel.visible

func _on_enemy_holder_level_clear() -> void:
	show()
	next_level_enabled = true
	$"../Timer".pause = true
	
func _on_arcade_scene_next_level() -> void:
	next_level_enabled = false
	hide()
	next_level_enabled = false
