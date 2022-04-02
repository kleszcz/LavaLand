extends StaticBody2D
class_name WallBase

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var hp = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func damage(value):
	hp -= value;
	if hp <= 0:
		self.queue_free()
	
