extends CanvasLayer

var useless_item_dialogue := ["I can't use this here.", "No.", "..."]
var mother_calling_dialogue := ["Mother is calling me.", "I should answer the door."]
var visible_characters := 0
var spoken : String


@onready var dialogue: RichTextLabel = $Dialogue


func _process(_delta: float) -> void:
	if visible_characters != dialogue.visible_characters:
		visible_characters = dialogue.visible_characters
		$AudioStreamPlayer.play()
		
	if Engine.get_process_frames() % 3 == 0:
		dialogue.visible_characters += 1

func speak(text: String, force: bool = false):
	if spoken != text or force:
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
