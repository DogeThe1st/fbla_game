extends Node2D

const bullet = preload("res://projectile.tscn")

func _on_player_shoot():
	print("SHOOTING")
	var bullet = bullet.instantiate()
	add_child(bullet)
	bullet.position = get_node("Player").position
	bullet.look_at(get_global_mouse_position())
	bullet.rotation = bullet.rotation + randf_range(-0.05, 0.05)

func _on_player_right_click():
	print("right_click")
