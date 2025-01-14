extends Node3D

func update():
	$ObjectHandler/FoodStew.visible = PhaseManager.plate
	$CanvasLayer/CloseUps/SubViewport/Drawer/Fork.visible = PhaseManager.fork_drawer

func _ready() -> void:
	update()
