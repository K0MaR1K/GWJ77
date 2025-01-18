extends Node2D

signal level_clear

@onready var timer: Control = $"../CanvasLayer/Timer"
@onready var arcade_scene: Node2D = $".."

var enemy_count: int:
	set(value):
		if value < enemy_count:
			$"..".set_enemy_count(value)
		enemy_count = value
		

func enemy_killed(score: int):
	enemy_count -= 1
	timer.add_time(1)
	if enemy_count == 0:
		level_clear.emit()
		
	arcade_scene.add_score(score)
		

func _ready() -> void:
	enemy_count = 0
	for child: Enemy in get_children():
		child.killed.connect(enemy_killed)
		enemy_count += 1
