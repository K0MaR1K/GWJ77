extends Node

enum Phase {INTRO, ROOM1, ROOM2, GAME2, ROOM3, GAME3}
enum LDJ {HAPPY, SAD, MYSTERIOUS}

var current_phase : Phase

# game logic
var computer_on := false
var can_leave_computer := false
var can_play_game := false
var loading_jingle := LDJ.HAPPY
var mother_at_door := false

# objects spawning
var plate := false
var fork_drawer := false

# levels
var level2 := false
var level3 := false
var human_enemy := false

func _ready() -> void:
	change_phase(Phase.ROOM1)

func next_phase():
	change_phase(current_phase + 1)

func is_room_phase():
	return current_phase in [Phase.ROOM1, Phase.ROOM2, Phase.ROOM3,]
	
func is_game_phase():
	return current_phase in [Phase.GAME2, Phase.GAME3]

func change_phase(next_phase: Phase):
	current_phase = next_phase
	print(current_phase)
	#
	## game logic
	#can_leave_computer = current_phase in [Phase.ROOM1, ]
	#can_play_game = current_phase in [Phase.INTRO, Phase.ROOM2]
	#loading_jingle = LDJ.HAPPY
	#mother_at_door = false
#
	## objects spawning
	#plate = false
	#fork_drawer = false
#
	## levels
	#level2 = false
	#level3 = false
	#
	match current_phase:
		Phase.INTRO:
			get_tree().change_scene_to_file.call_deferred("res://ui/desktop/main_menu.tscn")
			computer_on = false
			can_leave_computer = false
			can_play_game = true
			plate = false
			level2 = true
			level3 = false
			human_enemy = false
			loading_jingle = LDJ.HAPPY
		Phase.ROOM1:
			get_tree().change_scene_to_file.call_deferred("res://room/room_scene.tscn")
			computer_on = false
			can_leave_computer = true
			can_play_game = false
			fork_drawer = true
			mother_at_door = true
		Phase.ROOM2:
			plate = true
			can_leave_computer = true
			can_play_game = true
			level2 = true
			level3 = false
			mother_at_door = false
		Phase.GAME2:
			get_tree().change_scene_to_file.call_deferred("res://ui/desktop/main_menu.tscn")
			can_leave_computer = false
			plate = false
			level2 = true
			level3 = true
			loading_jingle = LDJ.SAD
			human_enemy = false
		Phase.GAME3:
			get_tree().change_scene_to_file.call_deferred("res://ui/desktop/main_menu.tscn")
			computer_on = false
			can_leave_computer = false
			plate = false
			level2 = true
			level3 = true
			loading_jingle = LDJ.SAD
			human_enemy = true
