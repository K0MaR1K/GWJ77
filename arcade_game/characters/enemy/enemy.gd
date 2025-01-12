class_name Enemy
extends Character

signal killed

var following_player: bool = false
var _start_position: Vector2

@onready var visibility_zone: Area2D = $VisibilityZone
@onready var player_enemy_line: RayCast2D = $PlayerEnemyLine

func _ready() -> void:
	_start_position = global_position

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
