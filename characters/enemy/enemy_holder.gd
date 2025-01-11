extends Node2D

var enemy_count := 0

func enemy_killed():
	enemy_count -= 1
	print(enemy_count)

func _ready() -> void:
	for child: Enemy in get_children():
		child.killed.connect(enemy_killed)
		enemy_count += 1
