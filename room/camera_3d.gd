extends Node3D

@export var mouse_sens: float = 0.0005
@onready var camera_3d: Camera3D = $Camera3D

func _input(event):
	if Global.is_inventory_hidden():
		if event.is_action_pressed("left"):
			var tween = get_tree().create_tween()
			tween.tween_property(self, "global_rotation:y", snapped(global_rotation.y + PI/2, PI/2), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		
		if event.is_action_pressed("right"):
			var tween = get_tree().create_tween()
			tween.tween_property(self, "global_rotation:y", snapped(global_rotation.y - PI/2, PI/2), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)

		#TODO: fix overrotation when mouse leaves the screen
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * mouse_sens)
			camera_3d.rotate_x(-event.relative.y * mouse_sens * 2)
			camera_3d.rotation.x = clamp(camera_3d.rotation.x, -1.2, 0.1)
