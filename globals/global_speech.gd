extends CanvasLayer

@onready var dialogue: RichTextLabel = $Dialogue
var visible_characters := 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		speak("AAAAAMOGUNS")

func _process(_delta: float) -> void:
	if visible_characters != dialogue.visible_characters:
		visible_characters = dialogue.visible_characters
		$AudioStreamPlayer.play()
		
	if Engine.get_process_frames() % 5 == 0:
		dialogue.visible_characters += 1

func speak(text: String):
	dialogue.text = "[center]" + text
	dialogue.visible_characters = 0
