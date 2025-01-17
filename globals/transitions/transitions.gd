extends CanvasLayer

enum {BLINK, DISSOLVE,}

@onready var transition_player: AnimationPlayer = $TransitionPlayer
@onready var dissolve: ColorRect = $Dissolve

func transition(trans_in : int, trans_out : int):
	match trans_in:
		BLINK:
			transition_player.play("blinking_in")
		DISSOLVE:
			transition_player.play("dissolve_in")
	
	await transition_player.animation_finished
	transition_player.play("RESET")
	$Dissolve.hide()
	$LowerEyelid.hide()
	$UpperEyelid.hide()
	
	match trans_out:
		BLINK:
			transition_player.play("blinking_out")
		DISSOLVE:
			transition_player.play("dissolve_out")

	PhaseManager.next_phase()
