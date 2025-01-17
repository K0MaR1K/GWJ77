class_name Enemy
extends Character

signal killed
signal mother_touched #TODO

const DUMMY = preload("res://arcade_game/characters/enemy/dummy.png")
const DUMMY_CORPSE = preload("res://arcade_game/characters/enemy/dummy_corpse.png")
const MOTHER = preload("res://arcade_game/characters/enemy/mother.png")
const MOTHER_CORPSE = preload("res://arcade_game/characters/enemy/mother_corpse.png")
const HUMAN = preload("res://arcade_game/characters/enemy/human.png")
const HUMAN_DEAD = preload("res://arcade_game/characters/enemy/human_dead.png")

var following_player: bool = false
var _start_position: Vector2

@onready var visibility_zone: Area2D = $VisibilityZone
@onready var player_enemy_line: RayCast2D = $PlayerEnemyLine

func _ready() -> void:
	_start_position = global_position
	if PhaseManager.human_enemy:
		$Legs.texture = HUMAN
		$Torso.texture = HUMAN
		$DeathSprite.texture = HUMAN_DEAD
	
func mother():
	if PhaseManager.human_enemy:
		$Legs.texture = MOTHER
		$Torso.texture = MOTHER
		$DeathSprite.texture = MOTHER_CORPSE
		$ShootTimer.wait_time = 1000
	else:
		$ShootTimer.wait_time = 1

func kill(knockback: Vector2):
	super.kill(knockback)
	following_player = false
	player_enemy_line.target_position = Vector2.ZERO
	killed.emit()

func check_for_player():
	if visibility_zone.has_overlapping_bodies():
		var body = visibility_zone.get_overlapping_bodies()[0]
		if body is Player:
			player_enemy_line.target_position = to_local(body.global_position)
			if not player_enemy_line.is_colliding():
				if not body.dead:
					direction = player_enemy_line.target_position.normalized()
					$Torso.look_at(body.global_position)
					following_player = true
					
				return
				
	direction = Vector2.ZERO
	following_player = false

func _process(delta: float) -> void:
	check_for_player()
	super._process(delta)


func _on_shoot_timer_timeout() -> void:
	if following_player and not dead:
		var bullet = BULLET.instantiate()
		bullet.set_as_enemy()
		
		bullet.direction = direction
		$"../..".add_child(bullet)
		bullet.global_position = global_position
		
		AudioManager.play_sound_2d(gun_shot_stream, -5, "SFX", global_position)


func _on_touch_zone_body_entered(body: Node2D) -> void:
	if $Legs.texture == MOTHER:
		print("MOTHER'S TOUCH")
