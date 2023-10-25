extends CharacterBody2D

var screen_size
var target_velocity = Vector2.ZERO
var gravity = 400
var side = "Enemy"
var health = 100
var game = true
var on_screen = true
var paused : bool = true
var bullets = 1
var player
var weapon_type : int = 2
var maxRounds : int = 5
var bulletside = "Right"
@export var Main : Node2D
func _ready():
	screen_size = get_viewport_rect().size
	Main = get_parent().get_parent()
	player = get_parent().get_parent().get_node("Player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	game = Main.game
	paused = Main.paused
	if game == true and paused == false:
		if player.global_position.x >= global_position.x:
			bulletside = "Right"
		else:
			bulletside = "Left"
		if weapon_type == 1:
			bullets = 5
			maxRounds = 5
		if weapon_type == 2:
			bullets = 3
			maxRounds = 30
		if weapon_type == 3:
			bullets = 1
			maxRounds = 40 
			fire_auto()
		#print(weapon_type)
		if health <= 0:
			self.queue_free()
		velocity = target_velocity
		if not is_on_floor():
			velocity.y += gravity
		move_and_slide()
func alert_death(dmg):
	health -= dmg


func _on_visible_on_screen_notifier_2d_screen_entered():
	on_screen = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	on_screen = false


func _on_timer_timeout():
	if game == true and paused == false:
		if on_screen == true:
			if weapon_type == 1:
				fire_burst()
			if weapon_type == 2:
				fire_shotgun()
				
func fire_burst():
	for x in range(3):
		var bulletspeed = 11
		var bulletrange1 = 0
		var bulletrange2 = 0
		await get_tree().create_timer(0.05).timeout
		Main.shoot(self.name, get_node("BulletSpawn" + str(bulletside)).global_position, side, bullets, bulletspeed, bulletrange1, bulletrange2, bulletside)

func fire_shotgun():
	var bulletspeed = 15
	var bulletrange1 = 0.05
	var bulletrange2 = -0.05
	Main.shoot(self.name, get_node("BulletSpawn" + str(bulletside)).global_position, side, bullets, bulletspeed, bulletrange1, bulletrange2, bulletside)

func fire_auto():
	var bulletspeed = 13
	var bulletrange1 = 0.075
	var bulletrange2 = -0.075
	Main.shoot(self.name, get_node("BulletSpawn" + str(bulletside)).global_positisweaaon, side, bullets, bulletspeed, bulletrange1, bulletrange2, bulletside)
