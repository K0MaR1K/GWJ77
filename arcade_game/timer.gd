extends Control

var time_left: float = 15.0
var pause: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not pause:
		time_left -= delta
		$EnemiesLeft.text = "time left: " + str(roundf(time_left))
