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
	
	%PopUps.text = get_phrase(score)
	
	if enemy_count == 0:
		level_clear.emit()	
	arcade_scene.add_score(score)
		
func get_phrase(score: int):
	if PhaseManager.human_enemy and score > 60 and score < 70:
		return "[color=red][pulse][shake]NOT HUMAN" 
	elif enemy_count == 2:
		return "[color=red][pulse][shake]KILL THEM!"
	elif score == 100:
		return "[rainbow][pulse]PREFIRED!"
	elif score > 80:
		return "[shake][pulse]GOOD SHOT!"
	elif score > 40:
		return "[wave amp=10][pulse]AIM FASTER"
	else:
		return "[pulse]TOO SLOW!"
		

func _ready() -> void:
	enemy_count = 0
	for child: Enemy in get_children():
		child.killed.connect(enemy_killed)
		enemy_count += 1
