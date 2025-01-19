extends CanvasLayer

signal finished_speech

var useless_item_dialogue := ["I can't use this [wave]here[/wave].", "No.", "[shake]...[/shake]"]
var mother_calling_dialogue := ["Mother is calling me.", "I should answer [wave]the door[/wave]."]

var mother_speech_1 : Array[String] = ["Gregor? [shake]My sweet Gregor?[/shake]", 
"Are you up? I have supper here.", 
"I will leave the plate at your door. You still have the utensils in your desk.",
"Love you!"]

var mother_speech_2 : Array[String] = ["Good morning.",
"May I see your conditions?",
"The sheets expire next week. You haven't been keeping them, have you.",
"Rather slippery of you."]

var visible_characters := 0
var spoken : String
var monologue := false

@onready var dialogue: RichTextLabel = $Dialogue
@onready var typewriter: AudioStreamPlayer = $Typewriter

func mother_speech(speech: Array[String]):
	monologue = true
	for line in speech:
		if not monologue:
			break
			
		await get_tree().create_timer(1.0).timeout
		mother_speak(line)
		await get_tree().create_timer(2.0 + 0.1 * line.length()).timeout
		
	monologue = false
	finished_speech.emit()

func _process(_delta: float) -> void:
	if dialogue.visible_characters >= dialogue.text.length() - 10:
		typewriter.stop()
		
	if Engine.get_process_frames() % 3 == 0:
		dialogue.visible_characters += 1

func speak(text: String, force: bool = false):
	if force:
		monologue = false
		
	if (spoken != text and not monologue) or force:
		play_typewriter()
		dialogue.modulate = Color.WHITE
		dialogue.text = "[center]" + text
		dialogue.visible_characters = 0
		spoken = text

func mother_speak(text: String):
	play_typewriter()
	dialogue.modulate = Color.ORANGE_RED
	dialogue.text = "[center]" + text
	dialogue.visible_characters = 0

func play_typewriter():
	typewriter.pitch_scale = randf() * 0.06 + 0.98
	typewriter.play()
	

func mother_at_door():
	speak(mother_calling_dialogue.pick_random())

func useless_item():
	speak(useless_item_dialogue.pick_random())

func clear():
	speak("", true)
