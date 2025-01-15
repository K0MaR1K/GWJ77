extends Node2D

signal next_level
signal time_out

const TILESET = preload("res://arcade_game/tilesets/tileset.tres")

var current_tileset = 0

func _ready() -> void:
	if PhaseManager.is_game_phase():
		pass
		#change_tileset()
		
	if Global.player_spawn_position == $Level1.global_position:
		set_enemy_count.call_deferred($EnemyHolder.enemy_count)
		
	elif Global.player_spawn_position == $Level2.global_position:
		set_enemy_count.call_deferred($EnemyHolder2.enemy_count)


func change_tileset(tileset: int = -1):
	if tileset == -1:	
		TILESET.set_source_id(0, current_tileset+10)
		TILESET.set_source_id(current_tileset+1, 0)
		current_tileset = current_tileset+1
	else:
		TILESET.set_source_id(tileset, 0)
		current_tileset = tileset
		
func set_enemy_count(enemy_count: int):
	%EnemiesLeft.text = "enemies left: " + str(enemy_count)

func _on_next_floor_area_body_entered(_body: Node2D) -> void:
	if $CanvasLayer/LevelClear.next_level_enabled:
		if PhaseManager.level2:
			Global.player_spawn_position = $Level2.global_position
			next_level.emit()
			set_enemy_count.call_deferred($EnemyHolder2.enemy_count)
		else:
			PhaseManager.next_phase()
			Global.reset_spawn_position()

func _on_next_floor_area_2_body_entered(_body: Node2D) -> void:
	if $CanvasLayer/LevelClear.next_level_enabled:
		if PhaseManager.level3:
			Global.player_spawn_position = $Level3.global_position
			next_level.emit()
		else:
			PhaseManager.next_phase()
			Global.reset_spawn_position()

func _on_timer_time_out() -> void:
	time_out.emit()


func _on_player_game_over() -> void:
	$CanvasLayer/Timer.pause = true
