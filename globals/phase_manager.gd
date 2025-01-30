extends Node

const METAL_ROD = preload("res://resources/metal_rod/metal_rod.tres")
const KEY = preload("res://resources/key/key.tres")
const TILESET = preload("res://arcade_game/tilesets/tileset.tres")

var current_tileset = 0

enum Phase {INTRO, GAME1, ROOM1_1, ROOM1_2, DESKTOP2, GAME2, ROOM2_1, ROOM2_2, DESKTOP3, GAME3, ROOM3_1, ROOM3_2, DESKTOP4, GAME4, FINAL}
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
var fork_cabinet := false
var fork_bookshelf := false
var chest := true
var note1 := false
var note2 := false
var note3 := false
var pvc_pipe := false

# levels
var level2 := false
var level3 := false
var human_enemy := false

func _ready() -> void:
	change_phase(Phase.INTRO)

func next_phase():
	change_phase(current_phase + 1)

func is_room_phase():
	return current_phase in [Phase.ROOM1_1, Phase.ROOM1_2, Phase.ROOM2_1, Phase.ROOM2_2,Phase.ROOM3_1, Phase.ROOM3_2,]
	
func is_game_phase():
	return current_phase in [Phase.GAME2, Phase.GAME3]

func change_phase(next: Phase):
	current_phase = next
	
	if is_game_phase():
		Global.hide_inventory()
	
	match current_phase:
		Phase.INTRO:
			get_tree().change_scene_to_file.call_deferred("res://ui/desktop/main_menu.tscn")

			plate = false
			fork_drawer = false
			fork_cabinet = false
			fork_bookshelf = false
			chest = true
			note1 = false
			note2 = false
			note3 = false
			pvc_pipe = false
			level2 = false
			level3 = false
			human_enemy = false
			computer_on = false
			can_leave_computer = false
			can_play_game = true
			loading_jingle = LDJ.HAPPY
			Global.inventory.clear()
			
		Phase.GAME1:
			AudioManager.shift_shooter21()
			get_tree().change_scene_to_file.call_deferred("res://arcade_game/main_scene.tscn")
			level2 = true
			level3 = false
			human_enemy = false
			
		Phase.ROOM1_1:
			get_tree().change_scene_to_file.call_deferred("res://room/room_scene.tscn")
			AudioManager.music_fade()
			computer_on = false
			can_leave_computer = true
			can_play_game = false
			fork_drawer = true
			note1 = true
			mother_at_door = true
			
		Phase.ROOM1_2:
			plate = true
			can_leave_computer = true
			mother_at_door = false
			
		Phase.DESKTOP2:
			#AudioManager.shift_shooter12()
			get_tree().change_scene_to_file.call_deferred("res://ui/desktop/main_menu.tscn")
			can_leave_computer = false
			can_play_game = true
			loading_jingle = LDJ.SAD
			
		Phase.GAME2:
			AudioManager.shift_shooter21()
			change_tileset()
			get_tree().change_scene_to_file.call_deferred("res://arcade_game/main_scene.tscn")
			level2 = true
			level3 = true
			human_enemy = false
			
		Phase.ROOM2_1:
			get_tree().change_scene_to_file.call_deferred("res://room/room_scene.tscn")
			AudioManager.music_fade()
			GlobalSpeech.speak("[shake]What? I don't remember having this key in my room.")
			plate = false
			pvc_pipe = true
			fork_cabinet = true
			note2 = true
			computer_on = false
			can_leave_computer = true
			can_play_game = false
			mother_at_door = true
			
			await get_tree().create_timer(1.0).timeout
			Global.add_to_inventory(KEY)
											
		Phase.ROOM2_2:
			plate = true
			mother_at_door = false
			
		Phase.DESKTOP3:
			get_tree().change_scene_to_file.call_deferred("res://ui/desktop/main_menu.tscn")
			AudioManager.shift_shooter12()
			computer_on = false
			can_leave_computer = false
			can_play_game = true
			loading_jingle = LDJ.MYSTERIOUS
			
		Phase.GAME3:
			AudioManager.shift_shooter21()
			change_tileset()
			get_tree().change_scene_to_file.call_deferred("res://arcade_game/main_scene.tscn")
			level2 = true
			level3 = true
			
		Phase.ROOM3_1:
			get_tree().change_scene_to_file.call_deferred("res://room/room_scene.tscn")
			AudioManager.music_fade()
			plate = false
			fork_bookshelf = true
			note3 = true
			computer_on = false
			can_leave_computer = true
			can_play_game = false
			mother_at_door = true
						
			await get_tree().create_timer(1.5).timeout
			Global.add_to_inventory(METAL_ROD)
											
		Phase.ROOM3_2:
			plate = true
			mother_at_door = false
			GlobalSpeech.player_final()
			
		Phase.DESKTOP4:
			get_tree().change_scene_to_file.call_deferred("res://ui/desktop/main_menu.tscn")
			AudioManager.shift_shooter12()
			computer_on = false
			can_leave_computer = false
			can_play_game = true
			loading_jingle = LDJ.MYSTERIOUS
			
		Phase.GAME4:
			AudioManager.shift_shooter21()
			change_tileset()
			get_tree().change_scene_to_file.call_deferred("res://arcade_game/main_scene.tscn")
			level2 = true
			level3 = true
			human_enemy = true
			
		Phase.FINAL:
			get_tree().change_scene_to_file.call_deferred("res://ui/final_screen.tscn")

func change_tileset(tileset: int = -1):
	if tileset == -1:	
		TILESET.set_source_id(0, current_tileset+4)
		TILESET.set_source_id(current_tileset+1, 0)
		current_tileset = current_tileset+1
	else:
		TILESET.set_source_id(tileset, 0)
	
