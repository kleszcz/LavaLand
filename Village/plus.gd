extends Node2D
class_name plus

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.y -= delta * speed
	pass


func _on_Timer_timeout():
	self.queue_free()
	pass # Replace with function body.
