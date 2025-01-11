class_name Character
extends CharacterBody2D

const BULLET = preload("res://bullet/bullet.tscn")

var SPEED := 50.0
var KNOCKBACK := 10.0

var direction : Vector2
var dead: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func kill(knockback: Vector2):
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "global_position", global_position + knockback * KNOCKBACK, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property(self, "global_rotation", -knockback.angle() + randf_range(-0.5, 0.5) , 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	
	$Legs.hide()
	$Torso.hide()
	$DeathSprite.show()
	
	dead = true
	set_process(false)
	set_physics_process(false)

func _process(_delta: float) -> void:
	if direction:
		velocity = direction * SPEED
		animation_player.play("walking")
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / 10.0)
		velocity.y = move_toward(velocity.y, 0, SPEED / 10.0)
		animation_player.play("idle")

	$Legs.global_rotation = direction.angle()
	move_and_slide()
