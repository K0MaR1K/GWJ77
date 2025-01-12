extends Node2D

signal level_clear

var enemy_count:
	set(value):
		enemy_count = value
		%EnemiesLeft.text = "enemies left: " + str(enemy_count)
		

func enemy_killed():
	enemy_count -= 1
	if enemy_count == 0:
		level_clear.emit()
		

func _ready() -> void:
	enemy_count = 0
	for child: Enemy in get_children():
		child.killed.connect(enemy_killed)
		enemy_count += 1
