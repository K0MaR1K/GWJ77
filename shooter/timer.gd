extends Control

signal time_out

@export var ticking : AudioStream 

var start_time: float = 10.0

var time_left: float = start_time
var pause: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not pause:
		var t = time_left
		time_left -= delta
		if time_left - 0.3 < floor(t - 0.3):
			AudioManager.play_sound(ticking, 5, "SFX")
			
		if time_left < 3:
			$TimeLeft.text = "time left: [shake][color=red]" + str(roundf(time_left))
		else:
			$TimeLeft.text = "time left: " + str(roundf(time_left))
			
		if time_left <= 0:
			pause = true
			time_out.emit()
			
	$AddedTime.position.y -= delta * 30.0

func add_time(time: float):
	time_left += time
	$AddedTime.text = "+" + str(time)
	$AddedTime.position.y = 2
