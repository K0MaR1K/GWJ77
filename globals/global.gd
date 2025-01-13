extends Node

var arcade_stage: int = 0

var player_spawn_position: Vector2 = Vector2(160, 145)

@onready var inventory: ItemList = $CanvasLayer/Inventory

func _ready() -> void:
	inventory.clear()
	add_to_inventory(preload("res://resources/fork/fork.tres"))
	

func add_to_inventory(item: Item):
	inventory.add_item(item.name, item.picture)


func show_inventory():
	inventory.show()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		show_inventory()
		
	if event.is_action_pressed("back"):
		inventory.hide()
