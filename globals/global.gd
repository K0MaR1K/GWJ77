extends Node

var arcade_stage: int = 0

var level1_spawn_position := Vector2(160, 145)
var player_spawn_position: Vector2 = level1_spawn_position

@onready var inventory: ItemList = $CanvasLayer/Inventory

var _requested_item: Request = null

func reset_spawn_position():
	player_spawn_position = level1_spawn_position

func _ready() -> void:
	inventory.clear()
	add_to_inventory(preload("res://resources/fork/fork.tres"))
	

func add_to_inventory(item: Item):
	inventory.add_item(item.name, item.picture)


func request_item(item: Item, node: Node):
	_requested_item = Request.new(item, node)
	show_inventory()

func show_inventory():
	inventory.show()

func hide_inventory():
	_requested_item = null
	inventory.hide()
	

func _input(event: InputEvent) -> void:
	if PhaseManager.is_room_phase():
		if event.is_action_pressed("ui_accept"):
			show_inventory()
			
		if event.is_action_pressed("back"):
			hide_inventory()

func _on_inventory_item_selected(index: int) -> void:
	if not _requested_item:
		pass
	elif inventory.get_item_text(index) == _requested_item.item.name:
		if _requested_item.node.has_method("send_item"):
			_requested_item.node.send_item(_requested_item.item)
	else:
		print("Can't use this item here")
		
	hide_inventory()


class Request:
	var item: Item
	var node: Node

	func _init(i: Item, n: Node) -> void:
		item = i
		node = n
