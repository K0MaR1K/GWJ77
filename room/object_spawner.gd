extends Node3D

func update():
	$ObjectHandler/FoodStew.visible = PhaseManager.plate
	$CanvasLayer/CloseUps/SubViewport/Drawer/Fork.visible = PhaseManager.fork_drawer
	$CanvasLayer/CloseUps/SubViewport/Drawer/Note.visible = PhaseManager.note1
	$CanvasLayer/CloseUps/SubViewport/Cabinet/Fork.visible = PhaseManager.fork_cabinet
	$CanvasLayer/CloseUps/SubViewport/Cabinet/Note.visible = PhaseManager.note2
	$CanvasLayer/CloseUps/SubViewport/Bookshelf/SlamGun.visible = PhaseManager.current_phase in [PhaseManager.Phase.ROOM3_1, PhaseManager.Phase.ROOM3_2]
	$CanvasLayer/CloseUps/SubViewport/Bookshelf/Fork.visible = PhaseManager.fork_bookshelf
	$CanvasLayer/CloseUps/SubViewport/Bookshelf/Note.visible = PhaseManager.note3
	
func _ready() -> void:
	update()
