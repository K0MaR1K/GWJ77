extends Node2D

signal level_clear

var enemy_count: int:
	set(value):
		if value < enemy_count:
			$"..".set_enemy_count(value)
		enemy_count = value
		

func enemy_killed():
	enemy_count -= 1
	if enemy_count == 0:
		level_clear.emit()
		

func _ready() -> void:
	enemy_count = 0
	for child: Enemy in get_children():
		child.killed.connect(enemy_killed)
		enemy_count += 1
