extends Polygon2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var max_point_dist = 20.0
export var min_point_dist = 10.0
export var grow_rate = 2.0
var run = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not run:
		return
	var polygon = self.polygon
	var uv = self.uv
	var space_state = get_world_2d().direct_space_state
	for i in range(0, polygon.size()):
		var vertex_num = polygon.size()
		if i >= vertex_num:
			break
		var point = polygon[i]
		var point_a = polygon[(i+1)%vertex_num]
		var point_b = polygon[(i-1)%vertex_num]
		var tangent = point_b - point_a
		var normal = Vector2(tangent.y, -tangent.x).normalized()
		var to_next = normal * delta * grow_rate
		var to_mid = (point_a+point_b)/2 - point
		var concave = to_next.dot(to_mid)
		if concave > 0 :
			point += to_mid
		point += to_next
		
		var force_split = false
		var result = space_state.intersect_ray(self.to_global(polygon[i]), self.to_global(point))
		if result.empty():
			polygon[i] = point
			uv[i] += to_next
		else:
			force_split = true
			var wall = result.collider as WallBase
			if wall:
				wall.damage(delta)
			else:
				var village = result.collider as Village
				if village:
					village.destroy()
		
		var dist_a = (point - point_a).length()
		force_split = (force_split and dist_a > min_point_dist) 
		if dist_a > max_point_dist or force_split:
			var new_point = (point + point_a) / 2
			var tangentn = point - point_a
			var normaln = Vector2(tangentn.y, -tangentn.x).normalized()
			new_point += normaln
			polygon.insert((i+1)%vertex_num, new_point)
			uv.insert((i+1)%vertex_num, uv[i])
#		if dist_a < min_point_dist:
#			polygon.remove(i)
#		if dist_b > max_point_dist:
#			var new_point = (point + point_b) / 2
#			polygon.insert(i, new_point)
		
	self.polygon = polygon
	self.uv = uv
	pass
	
func on_game_over():
	run = false
	pass
