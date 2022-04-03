extends PopupDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func on_game_over():
	# self.popup(Rect2(-70, -50, 140,100))
	var ui = self.get_parent().get_node("UI")
	ui.visible = false
	$VBoxContainer/Time.text = ui.get_node("Timer/Label").text
	self.popup()
	self.rect_position = Vector2(-85, -90)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
