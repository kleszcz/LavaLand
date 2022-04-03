extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var level01 = preload("res://main_level/Level_01.tscn")
onready var level02 = preload("res://main_level/Level_02.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var curr_lvl =  $"/root/Globals".current_level
	if curr_lvl == 1:
		var lvl = level01.instance()
		self.add_child(lvl)
		self.move_child(lvl, 0)
	elif curr_lvl == 2:
		var lvl = level02.instance()
		self.add_child(lvl)
		self.move_child(lvl, 0)
	pass # Replace with function body.

func _on_ToolButton_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_Next_pressed():
	var curr_lvl =  $"/root/Globals".current_level
	$"/root/Globals".current_level = (curr_lvl % 2) + 1
	get_tree().change_scene("res://main_level/main_level.tscn")
	pass # Replace with function body.
