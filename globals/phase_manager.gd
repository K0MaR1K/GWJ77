extends Node

enum Phase {INTRO, ROOM1, ROOM2, GAME2, ROOM3}
enum LDJ {HAPPY, SAD, MYSTERIOUS}

var current_phase : Phase = Phase.INTRO

var computer_on := false
var can_leave_computer := false
var plate := false
var level1 := false
var level2 := false
var level3 := false
var loading_jingle := LDJ.HAPPY

func next_phase():
	change_phase(current_phase + 1)

func change_phase(next_phase: Phase):
	current_phase = next_phase
	match current_phase:
		Phase.INTRO:
			computer_on = false
			can_leave_computer = false
			plate = false
			level1 = true
			level2 = true
			level3 = false
			loading_jingle = LDJ.HAPPY
		Phase.ROOM1:
			computer_on = false
			can_leave_computer = true
			plate = false
			level1 = true
			level2 = true
			level3 = false
		Phase.ROOM2:
			pass
		Phase.ROOM2:
			pass
