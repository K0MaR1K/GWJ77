class_name Character
extends CharacterBody2D

@export var footsteps : AudioStream
@export var gun_shot_stream : AudioStream
@export var human_shout : AudioStream
@export var dummy_shout : AudioStream

const BULLET = preload("res://arcade_game/bullet/bullet.tscn")
const BLOOD_SPATTER = preload("res://arcade_game/effects/blood spatter.png")

var SPEED := 50.0
var KNOCKBACK := 10.0

var direction : Vector2
var dead: bool = false
var footstep_t : int = 0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func kill(knockback: Vector2):
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "global_position", global_position + knockback * KNOCKBACK, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property(self, "global_rotation", -knockback.angle() + randf_range(-0.5, 0.5) , 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	
	$Legs.hide()
	$Torso.hide()
	$DeathSprite.show()
	
	
	if PhaseManager.human_enemy:
		AudioManager.play_sound_2d(human_shout, -5, "SFX", global_position)
		
		for i in range(3):
			var sprite := Sprite2D.new()
			get_node("/root/MainScene/SubViewport/ArcadeScene").add_child(sprite)
			
			sprite.texture = BLOOD_SPATTER
			sprite.z_index = i % 2
			sprite.global_position = global_position + knockback * randf_range(8, 16) + knockback.rotated(PI/2) * randf_range(-5, 5)
			
	elif self.has_method("get_input"):
		AudioManager.play_sound_2d(human_shout, -5, "SFX", global_position)
	else:
		AudioManager.play_sound_2d(dummy_shout, -5, "SFX", global_position)
		
	dead = true
	set_process(false)
	set_physics_process(false)

func _process(_delta: float) -> void:
	if direction:
		footstep_t += 1
		if footstep_t % 20 == 0:
			AudioManager.play_sound_2d(footsteps, 30, "SFX", global_position)
			
		velocity = direction * SPEED
		animation_player.play("walking")
		
		$Legs.global_rotation = direction.angle()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / 10.0)
		velocity.y = move_toward(velocity.y, 0, SPEED / 10.0)
		animation_player.play("idle")

	move_and_slide()
