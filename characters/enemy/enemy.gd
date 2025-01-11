class_name Enemy
extends Character

signal killed

var following_player: bool = false

@onready var visibility_zone: Area2D = $VisibilityZone
@onready var player_enemy_line: RayCast2D = $PlayerEnemyLine

func kill(knockback: Vector2):
	super.kill(knockback)
	killed.emit()

func check_for_player():
	if visibility_zone.has_overlapping_bodies():
		var body = visibility_zone.get_overlapping_bodies()[0]
		
		if body is Player:
			player_enemy_line.target_position = to_local(body.global_position)
			if not player_enemy_line.is_colliding() and not body.dead:
				
				if following_player:
					direction = player_enemy_line.target_position.normalized()
					$Torso.look_at(body.global_position)
					
				else:
					$ReactionTimer.start()
				return
				
	following_player = false

func _process(delta: float) -> void:
	check_for_player()
	
	super._process(delta)

# TODO: fix timer
func _on_reaction_timer_timeout() -> void:
	print("follow")
	following_player = true


func _on_shoot_timer_timeout() -> void:
	if following_player and not dead:
		var bullet = BULLET.instantiate()
		bullet.set_as_enemy()
		bullet.global_position = global_position
		
		bullet.direction = direction
		$"..".add_child(bullet)
