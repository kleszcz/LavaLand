extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = 0.0
export var period = 3.0
var fired = 0

var run = true
# Called when the node enters the scene tree for the first time.
func _ready():
	time = 0.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if run:
		time += delta
	
	if time > (fired+1)*period:
		print("Ping!")
		fired+=1
		get_tree().call_group("ResourceProducers", "_on_turn")
	$MarginContainer/CenterContainer/Label.text = format_time(time)
	pass

const digit_format = "%02d"

func format_time(time):
	var formatted = String()
	var minutes = digit_format % [time / 60]
	formatted += minutes + ':'
	var seconds = digit_format % [int(ceil(time)) % 60]
	formatted += seconds + ':'
	var thous = "%03d" % [int(1000*(time-int(time)))]
	formatted += thous
	return formatted


func on_game_over():
	run = false
	pass # Replace with function body.
