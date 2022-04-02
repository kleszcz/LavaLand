extends Path2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var t = 0.0
var idx = 0
var max_idx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var startPos = self.curve.interpolate(idx, t)
	$Sprite.position = startPos
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	t += delta
	if t > 1.0:
		idx += 1
		t -= 1.0
	
	var startPos = self.curve.interpolate(idx, t)
	$Sprite.position = startPos
	
	
	pass
