extends StaticBody2D
class_name WallBase

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var hp = 10;
var burning = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func damage(value):
	if not burning:
		$Sprite.animation = "fire"
		$AudioStreamPlayer.play()
		burning = true
	hp -= value;
	if hp <= 0:
		$Sprite.animation = "burned"
		$CollisionShape2D.disabled = true
	
