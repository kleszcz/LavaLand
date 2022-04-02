extends Node2D
class_name Villages

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var villages = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	villages = self.get_child_count()
	print("There are " + str(villages) + " villages on the map")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Village_destroyed():
	villages -= 1
	if villages == 0:
		print("GAME OVER!")
		get_tree().call_group("GameOverListeners", "on_game_over")
	pass # Replace with function body.

