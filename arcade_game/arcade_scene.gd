extends Node2D

signal next_level(pos: Vector2)

const TILESET = preload("res://arcade_game/tilesets/tileset.tres")

var current_tileset = 0

func change_tileset(tileset: int = -1):
	if tileset == -1:	
		TILESET.set_source_id(0, current_tileset+4)
		TILESET.set_source_id(current_tileset+1, 0)
		current_tileset = current_tileset+1
	else:
		TILESET.set_source_id(0, tileset)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		#change_tileset()
		pass


func _on_next_floor_area_body_entered(_body: Node2D) -> void:
	next_level.emit($Level2.global_position)


func _on_next_floor_area_2_body_entered(body: Node2D) -> void:
	next_level.emit($Level3.global_position)
