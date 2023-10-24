extends Node2D
const enemy = preload("res://Enemy.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("q"):
		var enemy = enemy.instantiate()
		add_child(enemy)
		enemy.global_position = get_global_mouse_position()
