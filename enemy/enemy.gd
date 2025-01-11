class_name Enemy
extends CharacterBody2D

const SPEED = 300.0
const KNOCKBACK = 10.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	
	var direction := Vector2.ZERO
	
	if direction:
		velocity = direction * SPEED
		animation_player.play("walking")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		animation_player.play("idle")
	
	$Legs.global_rotation = direction.angle()
	move_and_slide()

func kill(knockback: Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", global_position + knockback * KNOCKBACK, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	$Legs.hide()
	$Torso.hide()
	$DeathSprite.show()
	set_process(false)
