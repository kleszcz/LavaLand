extends StaticBody2D
class_name Village

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var plus = preload("res://Village/plus.tscn")
var onfire = false
var destroyed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func destroy():
	if onfire:
		return
	onfire = true
	$AnimatedSprite.animation = "fire"
	$Burning.play()
	$Timer.start(5)
	
func _on_Timer_timeout():
	if destroyed:
		print("Double destroy " + self.name)
	destroyed = true
	$Timer.stop()
	(self.get_parent() as Villages)._on_Village_destroyed()
	$AnimatedSprite.animation = "burned"
	$StaticBody2D.disabled = true
#	self.queue_free()


func _on_turn():
	if destroyed:
		return
	get_tree().call_group("ResourceUsers", "_on_new_resource")
	var p = plus.instance()
	p.position = $PlusStart.position
	$NewResource.play()
	self.add_child(p)
	pass # Replace with function body.
