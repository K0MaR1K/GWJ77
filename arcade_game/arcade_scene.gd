extends Node2D

signal next_level
signal time_out
signal mother_killed


const TILESET = preload("res://arcade_game/tilesets/tileset.tres")

var current_tileset = 0
var current_score := 0

@onready var mother: Enemy = $EnemyHolder3/Mother

func _ready() -> void:
	GlobalSpeech.clear()
	if PhaseManager.is_game_phase():
		pass
		#change_tileset()
		
	if Global.player_spawn_position == $Level1.global_position:
		set_enemy_count.call_deferred($EnemyHolder.enemy_count)
		
	elif Global.player_spawn_position == $Level2.global_position:
		set_enemy_count.call_deferred($EnemyHolder2.enemy_count)

	mother.mother()
	reset()
	
func reset():
	$GroundLayer.show()
	$DecorationsLayer.show()
	$CanvasLayer.show()
	$Spotlight.hide()
	$DirectionalLight2D.hide()

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

func add_score(score : int):
	current_score += score
	%Score.text = "score: " + str(current_score)

func _on_next_floor_area_body_entered(_body: Node2D) -> void:
	if $CanvasLayer/LevelClear.next_level_enabled:
		if PhaseManager.level2:
			Global.player_spawn_position = $Level2.global_position
			next_level.emit()
			set_enemy_count.call_deferred($EnemyHolder2.enemy_count)
		else:
			Transitions.transition(Transitions.DISSOLVE, Transitions.BLINK)
			Global.reset_spawn_position()

func _on_next_floor_area_2_body_entered(_body: Node2D) -> void:
	if $CanvasLayer/LevelClear.next_level_enabled:
		if PhaseManager.level3:
			Global.player_spawn_position = $Level3.global_position
			next_level.emit()
		else:
			Transitions.transition(Transitions.DISSOLVE, Transitions.BLINK)
			Global.reset_spawn_position()


func _on_next_floor_area_3_body_entered(body: Node2D) -> void:
	if $CanvasLayer/LevelClear.next_level_enabled:
		Transitions.transition(Transitions.DISSOLVE, Transitions.BLINK)
		Global.reset_spawn_position()

func _on_timer_time_out() -> void:
	time_out.emit()


func _on_player_game_over() -> void:
	$CanvasLayer/Timer.pause = true


func _on_mother_killed() -> void:
	if PhaseManager.human_enemy:
		mother_killed.emit()
		$Spotlight.global_position = mother.global_position
		$AnimationPlayer.play("mother_killed")
		
		$GroundLayer.hide()
		$DecorationsLayer.hide()
		$CanvasLayer.hide()
		$Spotlight.show()
		
		AudioManager.pitch_scale_down(0.01, 3.0)
		$DirectionalLight2D.show()
