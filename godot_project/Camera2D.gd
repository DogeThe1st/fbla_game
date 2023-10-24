extends Camera2D

func _physics_process(_delta):
	var player = get_parent().get_node("Player")
	if player.global_position.x >= get_node("Marker2D2").global_position.x:
		self.position.x += player.get_last_motion().x
	if player.global_position.x <= get_node("Marker2D").global_position.x:
		self.position.x += player.get_last_motion().x
