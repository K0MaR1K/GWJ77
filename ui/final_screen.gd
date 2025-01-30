extends SubViewportContainer


func _ready() -> void:
	await get_tree().create_timer(10.0).timeout
	PhaseManager.change_phase(PhaseManager.Phase.INTRO)
	SilentWolf.Scores.save_score(Global.player_name, Global.player_score)
	Global.player_score = 0
