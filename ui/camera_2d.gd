extends Camera2D

@onready var player: CharacterBody2D = %Player

func _ready() -> void:
	global_position = player.global_position

func _process(_delta: float) -> void:
	global_position = (player.global_position * 3 + get_global_mouse_position()) / 4
