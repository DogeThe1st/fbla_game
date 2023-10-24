extends Node2D

const bullet = preload("res://projectile.tscn")
const enemy = preload("res://Enemy.tscn")
const Level0 = preload("res://Level0.tscn")
const Level1 = preload("res://Level1.tscn")
#const Level2 = preload("res://Level2.tscn")
#const Level3 = preload("res://Level3.tscn")
#const Level4 = preload("res://Level4.tscn")

var game : bool = false
var paused : bool = false
var levelnum = 0
var max_level = 1
var main_menu : bool = true
func _on_player_shoot(name, direction, side, bullets, speed, bulletrange1, bulletrange2):
	shoot(name, direction, side, bullets, speed, bulletrange1, bulletrange2)

func shoot(name, direction, side, bullets, speed, bulletrange1, bulletrange2):
	for x in range(bullets):
		var bullet = bullet.instantiate()
		add_child(bullet)
		if side == "Player":
			bullet.global_position = get_node(name + "/BulletSpawn").global_position
		else:
			bullet.global_position = get_node(("Level" + str(levelnum)) + "/" + name + "/BulletSpawn").global_position
		bullet.look_at(direction)
		bullet.rotation = bullet.rotation + randf_range(bulletrange1, bulletrange2)
		bullet.side = side
		bullet.speed = speed

func _process(delta):
	if paused == false and main_menu == false:
		game = true
		get_node("Pause").hide()
		get_node("main menu").hide()
	else:
		game = false
		if paused == false and main_menu == true:
			get_node("Pause").hide()
			get_node("main menu").show()
			game = false
		elif paused == true and main_menu == false:
			get_node("Pause").show()
			get_node("main menu").hide()
			game = false
		else:
			game = false
			main_menu = true
			paused = false
	if Input.is_action_just_pressed("escape"):
		if main_menu == false:
			if paused == true:
				paused = false
			else:
				paused = true
			get_node("Pause").show()
	if Input.is_action_just_pressed("right_click"):
		if main_menu == false and paused == false and game == true:
			level_load()

func level_load():
	if levelnum < max_level:
		get_node("Level" + str(levelnum)).queue_free()
		levelnum += 1
		var levelToInstantiate = "Level" + str(levelnum)
		var level = get(levelToInstantiate).instantiate()
		add_child(level)
		level.name = levelToInstantiate


func _on_button_pressed():
	paused = false
	main_menu = true
	game = false


func _on_button_2_pressed():
	paused = false
	game = true
	main_menu = false


func _on_button_3_pressed():
	get_tree().quit()


func _on_button_4_pressed():
	game = true
	paused = false
	main_menu = false
