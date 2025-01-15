extends Node

var arcade_stage: int = 0

var level1_spawn_position := Vector2(160, 145)
var player_spawn_position: Vector2 = level1_spawn_position

@onready var inventory: ItemList = $CanvasLayer/Inventory

func reset_spawn_position():
	player_spawn_position = level1_spawn_position

func _ready() -> void:
	inventory.clear()
	add_to_inventory(preload("res://resources/fork/fork.tres"))
	

func add_to_inventory(item: Item):
	inventory.add_item(item.name, item.picture)


func show_inventory():
	inventory.show()

func _input(event: InputEvent) -> void:
	if PhaseManager.is_room_phase():
		if event.is_action_pressed("ui_accept"):
			show_inventory()
			
		if event.is_action_pressed("back"):
			inventory.hide()
