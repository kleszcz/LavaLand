extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var Wall = preload("res://Wall/Wall.tscn")

var inventory = 3
var can_spawn = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var params = Physics2DShapeQueryParameters.new()
	params.shape_rid = $CollisionShape2D.shape.get_rid()
	params.transform = self.transform
	var collisions = space_state.intersect_shape(params)
	if collisions or $"/root/Globals".mouse_owners != 0:
		$Sprite.animation = "nok"
		can_spawn = false
	elif inventory > 0:
		$Sprite.animation = "ok"
		can_spawn = true
	else:
		$Sprite.animation = "empty"
		can_spawn = false


	# if try_spawn:
	# 	try_spawn = false
		
	# 	var w = Wall.instance()
	# 	w.position = self.position
		
	# 	var params = Physics2DShapeQueryParameters.new()
	# 	params.shape_rid = (w.get_child(1) as CollisionShape2D).shape.get_rid()
	# 	params.transform = w.transform
	# 	var collisions = space_state.intersect_shape(params)
	# 	if collisions:
	# 		print("Hit!")
	# 		w.queue_free()
	# 	else:
	# 		inventory -= 1
	# 		get_tree().get_root().add_child(w)
		
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse = self.get_global_mouse_position()
	self.position = mouse
	if can_spawn and Input.is_action_just_pressed("place_wall") and inventory > 0:
		spawn()
	pass

func spawn():
	var w = Wall.instance()
	w.position = self.position
	inventory -= 1
	get_tree().get_root().add_child(w)

func _on_new_resource():
	inventory += 1
	print("adding resource")
	pass # Replace with function body.
