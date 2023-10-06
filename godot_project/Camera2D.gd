extends Camera2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().get_node("Player").global_position.x > get_node("Marker2D2").global_position.x:
		self.position.x += 5
	if get_parent().get_node("Player").global_position.x < get_node("Marker2D").global_position.x:
		self.position.x -= 5
