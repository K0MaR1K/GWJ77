class_name Player
extends CharacterBody2D

const BULLET = preload("res://bullet/bullet.tscn")

const SPEED = 100.0

var direction : Vector2

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func get_input():
	return Input.get_vector("left", "right", "up", "down")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		var bullet = BULLET.instantiate()
		bullet.global_position = global_position
		bullet.direction = Vector2.from_angle(global_rotation)
		$"..".add_child(bullet)
		

func _physics_process(delta: float) -> void:

	direction = get_input()
	if direction:
		velocity = direction * SPEED
		animation_player.play("walking")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		animation_player.play("idle")
	
	look_at(get_global_mouse_position())
	$Legs.global_rotation = direction.angle()
	move_and_slide()
