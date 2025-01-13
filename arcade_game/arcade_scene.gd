extends Node2D

signal next_level
signal time_out

const TILESET = preload("res://arcade_game/tilesets/tileset.tres")

var current_tileset = 0

func _ready() -> void:
	if Global.player_spawn_position == $Level1.global_position:
		set_enemy_count.call_deferred($EnemyHolder.enemy_count)
		
	elif Global.player_spawn_position == $Level2.global_position:
		set_enemy_count.call_deferred($EnemyHolder2.enemy_count)


func change_tileset(tileset: int = -1):
	if tileset == -1:	
		TILESET.set_source_id(0, current_tileset+4)
		TILESET.set_source_id(current_tileset+1, 0)
		current_tileset = current_tileset+1
	else:
		TILESET.set_source_id(0, tileset)
		current_tileset = tileset

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		return
		change_tileset()
		
func set_enemy_count(enemy_count: int):
	%EnemiesLeft.text = "enemies left: " + str(enemy_count)

func _on_next_floor_area_body_entered(_body: Node2D) -> void:
	if $CanvasLayer/LevelClear.next_level_enabled:
		Global.player_spawn_position = $Level2.global_position
		next_level.emit()
		set_enemy_count.call_deferred($EnemyHolder2.enemy_count)

func _on_next_floor_area_2_body_entered(_body: Node2D) -> void:
	if $CanvasLayer/LevelClear.next_level_enabled:
		Global.player_spawn_position = $Level3.global_position
		next_level.emit()


func _on_timer_time_out() -> void:
	time_out.emit()


func _on_player_game_over() -> void:
	$CanvasLayer/Timer.pause = true
