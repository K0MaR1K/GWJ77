extends Node

var player_name : String = "Gregor"
var player_score : int = 0
var arcade_stage: int = 0

var level1_spawn_position := Vector2(160, 145)
var level2_spawn_position := Vector2(-181, 361)
var level3_spawn_position := Vector2(721, 403)

var player_spawn_position: Vector2 = level1_spawn_position

@onready var inventory: ItemList = $CanvasLayer/Inventory
@onready var dithering_effect: ColorRect = $CanvasLayer/DitheringEffect
@onready var added_item: TextureRect = $CanvasLayer/AddedItem

var _requested_item: Request = null

func reset_spawn_position():
	player_spawn_position = level1_spawn_position
	if PhaseManager.current_phase >= PhaseManager.Phase.GAME2:
		player_spawn_position = level2_spawn_position

func _ready() -> void:
	hide_inventory()
	inventory.clear()
	
	SilentWolf.configure({
		"api_key": "rjZjsRzXs49HCLmSAbSsZ6RYz29Sfrw05hDsBV01",
		"game_id": "MiamiVice",
		"log_level": 1 })

	SilentWolf.configure_scores({ "open_scene_on_close": "res://ui/desktop/main_menu.tscn" })
	

func add_to_inventory(item: Item):
	inventory.add_item(item.name, item.picture)
	added_item.position.y = 600
	added_item.set_texture(item.picture)
	var tween = get_tree().create_tween()
	tween.tween_property(added_item, "position:y", 800, 1.5).set_trans(Tween.TRANS_EXPO)


func request_item(item: Item, node: Node):
	_requested_item = Request.new(item, node)
	show_inventory()

func show_inventory():
	inventory.show()
	dithering_effect.show()
	
	if GlobalSpeech.dialogue.text == "[color=purple]Press space to open and close inventory.":
		GlobalSpeech.clear()
	
	
func hide_inventory():
	_requested_item = null
	inventory.hide()
	dithering_effect.hide()
	inventory.deselect_all()
	
func is_inventory_hidden():
	return not inventory.visible

func _input(event: InputEvent) -> void:
	if PhaseManager.is_room_phase():
		if event.is_action_pressed("ui_accept"):
			if inventory.visible:
				hide_inventory()
			else:
				show_inventory()
			
		if event.is_action_pressed("back"):
			hide_inventory()

func _on_inventory_item_selected(index: int) -> void:
	if not _requested_item:
		GlobalSpeech.speak("This is a " + inventory.get_item_text(index))
	elif inventory.get_item_text(index) == _requested_item.item.name:
		if _requested_item.node.has_method("send_item"):
			_requested_item.node.send_item(_requested_item.item)
			inventory.remove_item(index)
	else:
		GlobalSpeech.speak("Can't use this item here")
		
	hide_inventory()


class Request:
	var item: Item
	var node: Node

	func _init(i: Item, n: Node) -> void:
		item = i
		node = n
