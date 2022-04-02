extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var Wall = preload("res://Wall/Wall.tscn")

export var hit = Vector2(0,0)
var inventory = 3
var try_spawn = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():	
	draw_line(Vector2(0,0), self.to_local(hit), Color.red)
	pass
	

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(self.position, Vector2(0,0))
	if result :
		hit = result.position
	if try_spawn:
		try_spawn = false
		
		var w = Wall.instance()
		w.position = self.position
		
		var params = Physics2DShapeQueryParameters.new()
		params.shape_rid = (w.get_child(1) as CollisionShape2D).shape.get_rid()
		params.transform = w.transform
		var collisions = space_state.intersect_shape(params)
		if collisions:
			print("Hit!")
			w.queue_free()
		else:
			inventory -= 1
			get_tree().get_root().add_child(w)
		
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse = self.get_global_mouse_position()
	self.position = mouse
	if Input.is_action_just_pressed("place_wall") and inventory > 0 and $"/root/Globals".mouse_owners == 0:
		try_spawn = true
	update()
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
