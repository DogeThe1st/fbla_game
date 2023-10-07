extends Node2D

const bullet = preload("res://projectile.tscn")

func _on_player_shoot(name, direction, side):
	shoot(name, direction, side)

func shoot(name, direction, side):
	var bullet = bullet.instantiate()
	add_child(bullet)
	bullet.global_position = get_node(name + "/BulletSpawn").global_position
	bullet.look_at(direction)
	bullet.rotation = bullet.rotation + randf_range(-0.05, 0.05)
	bullet.side = side
func _on_player_right_click():
	print("right_click")


func _on_enemy_shoot(name, direction, side):
	shoot(name, direction, side)
