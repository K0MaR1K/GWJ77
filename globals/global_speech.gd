extends CanvasLayer

var useless_item_dialogue := ["I can't use this here.", "No.", "..."]
var mother_calling_dialogue := ["Mother is calling me.", "I should answer the door."]

var mother_speech_1 : Array[String] = ["Gregor? My sweet Gregor?", 
"Are you up? I have supper here.", 
"I will leave the plate at your door. You still have the utensils in your desk.",
"Love you!"]

var visible_characters := 0
var spoken : String
var monologue := false

@onready var dialogue: RichTextLabel = $Dialogue

func mother_speech(speech: Array[String]):
	monologue = true
	for line in speech:
		if not monologue:
			break
		await get_tree().create_timer(1.0).timeout
		mother_speak(line)
		await get_tree().create_timer(2.0 + 0.1 * line.length()).timeout
		
	monologue = false

func _process(_delta: float) -> void:
	if visible_characters != dialogue.visible_characters:
		visible_characters = dialogue.visible_characters
		$AudioStreamPlayer.play()
		
	if Engine.get_process_frames() % 3 == 0:
		dialogue.visible_characters += 1

func speak(text: String, force: bool = false):
	if force:
		monologue = false
	if (spoken != text and not monologue) or force:
			dialogue.modulate = Color.WHITE
			dialogue.text = "[center]" + text
			dialogue.visible_characters = 0
			spoken = text

func mother_speak(text: String):
	dialogue.modulate = Color.ORANGE_RED
	dialogue.text = "[center]" + text
	dialogue.visible_characters = 0

func mother_at_door():
	speak(mother_calling_dialogue.pick_random())

func useless_item():
	speak(useless_item_dialogue.pick_random())

func clear():
	speak("", true)
