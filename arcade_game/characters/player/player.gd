class_name Player
extends Character

signal game_over

func _ready() -> void:
	SPEED = 100.0
	global_position = Global.player_spawn_position

func get_input():
	return Input.get_vector("left", "right", "up", "down")

func kill(knockback: Vector2):
	super.kill(knockback)
	game_over.emit()
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and not dead:
		var bullet = BULLET.instantiate()
		bullet.global_position = global_position
		bullet.direction = Vector2.from_angle(global_rotation)
		$"..".add_child(bullet)
		

func _process(delta: float) -> void:
	direction = get_input()
	look_at(get_global_mouse_position())
	
	super._process(delta)


func _on_arcade_scene_next_level() -> void:
	global_position = Global.player_spawn_position


func _on_arcade_scene_time_out() -> void:
	super.kill(Vector2.ZERO)
