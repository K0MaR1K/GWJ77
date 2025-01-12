extends Node2D

const TILESET = preload("res://tilesets/tileset.tres")

var current_tileset = 0

func change_tileset():	
	TILESET.set_source_id(0, current_tileset+4)
	TILESET.set_source_id(current_tileset+1, 0)
	current_tileset = current_tileset+1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		#change_tileset()
		pass


func _on_next_floor_area_body_entered(body: Node2D) -> void:
	if $CanvasLayer/LevelClear.next_level_enabled:
		get_tree().change_scene_to_file.call_deferred("res://main_scene.tscn")
