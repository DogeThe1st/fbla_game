extends Area2D

var velocity
# Called when the node enters the scene tree for the first time.
func _process(delta):
	#self.global_position += Vector2(10, 0).rotated(self.global_rotation)
	move_local_x(10)
