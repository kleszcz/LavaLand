extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var Wall = preload("res://Wall/Wall.tscn")

export var hit = Vector2(0,0)
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
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse = self.get_global_mouse_position()
	self.position = mouse
	if Input.is_action_pressed("place_wall"):
		var w = Wall.instance()
		w.position = self.position
		get_tree().get_root().add_child(w)
	update()
	pass
