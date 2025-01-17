extends Node

enum Phase {INTRO, ROOM1_1, ROOM1_2, GAME2, ROOM2_1, ROOM2_2, GAME3}
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
	change_phase(Phase.ROOM1_1)

func next_phase():
	change_phase(current_phase + 1)

func is_room_phase():
	return current_phase in [Phase.ROOM1_1, Phase.ROOM1_2,]
	
func is_game_phase():
	return current_phase in [Phase.GAME2, Phase.GAME3]

func change_phase(next: Phase):
	current_phase = next
	print(current_phase)

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
			
		Phase.ROOM1_1:
			get_tree().change_scene_to_file.call_deferred("res://room/room_scene.tscn")
			computer_on = false
			can_leave_computer = true
			can_play_game = false
			fork_drawer = true
			mother_at_door = true
			GlobalSpeech.mother_speech(GlobalSpeech.mother_speech_1)
			
		Phase.ROOM1_2:
			plate = true
			can_leave_computer = true
			mother_at_door = false
			
		Phase.GAME2:
			get_tree().change_scene_to_file.call_deferred("res://ui/desktop/main_menu.tscn")
			can_leave_computer = false
			can_play_game = true
			plate = false
			level2 = true
			level3 = true
			loading_jingle = LDJ.SAD
			human_enemy = false
			
		Phase.ROOM2_1:
			get_tree().change_scene_to_file.call_deferred("res://room/room_scene.tscn")
			computer_on = false
			can_leave_computer = true
			can_play_game = false
			fork_drawer = true
			mother_at_door = true
						
		Phase.ROOM2_2:
			plate = true
			can_leave_computer = true
			mother_at_door = false
			
		Phase.GAME3:
			get_tree().change_scene_to_file.call_deferred("res://ui/desktop/main_menu.tscn")
			computer_on = false
			can_leave_computer = false
			can_play_game = true
			plate = false
			level2 = true
			level3 = true
			loading_jingle = LDJ.MYSTERIOUS
			human_enemy = true
