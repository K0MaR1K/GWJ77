extends Camera2D

@onready var player: CharacterBody2D = %Player
var mother_killed := false


func _ready() -> void:
	global_position = Global.player_spawn_position

func _process(_delta: float) -> void:
	if not mother_killed:
		global_position = (player.global_position * 3 + get_global_mouse_position()) / 4
	else: global_position = $"../ArcadeScene".mother.global_position
