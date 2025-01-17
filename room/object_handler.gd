extends Node3D

signal update_items

@onready var pointer: Pointer = $"../CanvasLayer/Pointer"
@onready var sub_viewport: SubViewport = $"../CanvasLayer/CloseUps/SubViewport"
@onready var close_ups: SubViewportContainer = $"../CanvasLayer/CloseUps"

var close_up: bool = false

func _ready() -> void:
	for object: StaticBody3D in get_children():
		object.mouse_entered.connect(_on_object_mouse_entered)
		object.mouse_exited.connect(_on_object_mouse_exited)

func set_mouse_input(c_up: bool):
	Global.hide_inventory()
	
	$"../CanvasLayer/CloseUps/SubViewport/ModulateRect".visible = c_up
	$"../CanvasLayer/ArrowLeft".visible = not c_up
	$"../CanvasLayer/ArrowRight".visible = not c_up
	$"../CanvasLayer/ArrowBack".visible = c_up
	
	pointer.set_base_pointer()
	sub_viewport.handle_input_locally = c_up
	self.close_up = c_up
	if c_up:
		close_ups.mouse_filter = Control.MOUSE_FILTER_STOP
		
	else:
		close_ups.mouse_filter = Control.MOUSE_FILTER_PASS
	

func _on_object_mouse_entered() -> void:
	if Global.is_inventory_hidden():
		pointer.set_select_pointer()
	
func _on_object_mouse_exited() -> void:
	if Global.is_inventory_hidden():
		pointer.set_base_pointer()

func go_back():
	if $"../CanvasLayer/CloseUps/SubViewport/Note1".visible:
		$"../CanvasLayer/CloseUps/SubViewport/Note1".hide()
		return
		
	set_mouse_input(false)
	for child in sub_viewport.get_children():
		child.hide()
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("back"):
			go_back()
			
	if close_up:
		sub_viewport.push_input(event)

func _on_computer_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed("shoot") and not close_up:
		if PhaseManager.mother_at_door:
			GlobalSpeech.mother_at_door()
		else:
			if PhaseManager.can_play_game:
				PhaseManager.next_phase()
			else:
				get_tree().change_scene_to_file.call_deferred("res://ui/desktop/main_menu.tscn")


func _on_drawer_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed("shoot") and not close_up:
		if PhaseManager.mother_at_door:
			GlobalSpeech.mother_at_door()
		else:
			$"../CanvasLayer/CloseUps/SubViewport/Drawer".show()
			set_mouse_input(true)


func _on_fork_input_event(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and close_up:
		if PhaseManager.mother_at_door:
			GlobalSpeech.mother_at_door()
		else:
			PhaseManager.fork_drawer = false
			update_items.emit()
			Global.add_to_inventory(preload("res://resources/fork/fork.tres"))




func _on_boombox_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed("shoot") and not close_up:
		$"../CanvasLayer/CloseUps/SubViewport/Boombox".show()
		set_mouse_input(true)


func _on_door_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event.is_action_pressed("shoot") and not close_up:
		if PhaseManager.mother_at_door:
			PhaseManager.next_phase()
			update_items.emit()


func _on_note_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and close_up:
		PhaseManager.note1 = false
		$"../CanvasLayer/CloseUps/SubViewport/Note1".show()
		update_items.emit()
