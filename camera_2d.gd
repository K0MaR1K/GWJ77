extends Camera2D

@onready var player: CharacterBody2D = $"../Player"

func _process(delta: float) -> void:
	global_position = (player.global_position * 3 + get_global_mouse_position()) / 4
	%CRTEffect.global_position = get_screen_center_position() - get_viewport_rect().size / 2
