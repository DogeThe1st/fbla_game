extends Area2D

var velocity
var health
# Called when the node enters the scene tree for the first time.
func _process(delta):
	move_local_x(10)
	if self.is_visible() == false:
		print("im dead")
		self.queue_free()
