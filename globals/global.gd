extends Node

var player_name : String = "Gregor"
var player_score : int = 0
var arcade_stage: int = 0

var level1_spawn_position := Vector2(160, 145)
var level2_spawn_position := Vector2(-181, 361)
var level3_spawn_position := Vector2(721, 403)

var player_spawn_position: Vector2 = level1_spawn_position

func reset_spawn_position():
	player_spawn_position = level1_spawn_position

func _ready() -> void:
	
	SilentWolf.configure({
		"api_key": "rjZjsRzXs49HCLmSAbSsZ6RYz29Sfrw05hDsBV01",
		"game_id": "MiamiVice",
		"log_level": 1 })

	SilentWolf.configure_scores({ "open_scene_on_close": "res://ui/desktop/main_menu.tscn" })
