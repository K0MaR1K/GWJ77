class_name Bullet
extends Area2D

const SPEED = 600.0

var direction: Vector2

func _ready() -> void:
	global_rotation = direction.angle()

func _physics_process(delta: float) -> void:
	global_position += direction * SPEED * delta


func _on_body_entered(body: Node2D) -> void:	
	$AnimationPlayer.play("collide")
	if body is Character and not body.dead:
		body.kill(direction)
		
	direction = Vector2.ZERO
	scale = Vector2(0.2, 0.2)

func set_as_enemy():
	set_collision_mask_value(2, true)
	set_collision_mask_value(4, false)
