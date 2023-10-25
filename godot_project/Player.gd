extends CharacterBody2D

signal shoot
signal die
var screen_size
var direction
var target_velocity = Vector2.ZERO
var health : int = 100
var game : bool = true
var shifted = 1
var side = "Player"
var paused : bool = true
var bullets : int = 5
var weapon_type : int = 3
var maxRounds : int = 5
var bulletside = "Right"
# 1 = Burst
# 2 = Shotgun
# 3 = Full Auto
@export var move_speed = 305
@export var gravity = 400
@export var jump_force = -600

func _ready():
	screen_size = get_viewport_rect().size
	direction = Vector2.ZERO

func _process(delta):
	game = get_parent().game
	paused = get_parent().paused
	if health > 0 and game == true and paused == false:
		if weapon_type == 1:
			bullets = 5
			maxRounds = 5
		if weapon_type == 2:
			bullets = 3
			maxRounds = 30
		if weapon_type == 3:
			bullets = 1
			maxRounds = 40 
		direction = Vector2.ZERO
		if Input.is_action_just_pressed("1"):
			weapon_type = 1
		if Input.is_action_just_pressed("2"):
			weapon_type = 2
		if Input.is_action_just_pressed("3"):
			weapon_type = 3
		if Input.is_action_pressed("left"):
			direction.x -= 1
		if Input.is_action_pressed("right"):
			direction.x += 1
		if Input.is_action_just_pressed("click"):
			if weapon_type == 1:
				fire_burst()
			if weapon_type == 2:
				fire_shotgun()
		if Input.is_action_pressed("click"):
			if weapon_type == 3:
				fire_auto()
		if Input.is_action_pressed("shift"):
			shifted = 1.5
			print(bulletside)
		else:
			shifted = 1
		direction = direction.normalized()
		target_velocity.x = direction.x * move_speed * shifted
		if is_on_floor():
			if Input.is_action_pressed("up"):
				target_velocity.y = jump_force
			else:
				target_velocity.y = 0
		else:
			target_velocity.y += gravity * delta
		if is_on_ceiling():
			target_velocity.y += 50
		velocity = target_velocity
		if velocity.x > 0 or velocity.x < 0:
			get_node("AnimatedSprite2D").play("walk")
		else:
			get_node("AnimatedSprite2D").play("idle")
		if direction.x < 0:
			bulletside = "Right"
		if direction.x > 0:
			bulletside = "Left"
		move_and_slide()

func fire_burst():
	for x in range(3):
		var bulletspeed = 11
		var bulletrange1 = 0
		var bulletrange2 = 0
		await get_tree().create_timer(0.05).timeout
		shoot.emit(self.name, get_node("BulletDir" + str(bulletside)).get_global_position(), side, bullets, bulletspeed, bulletrange1, bulletrange2, bulletside)

func fire_shotgun():
	var bulletspeed = 15
	var bulletrange1 = 0.05
	var bulletrange2 = -0.05
	shoot.emit(self.name, get_node("BulletDir" + str(bulletside)).get_global_position(), side, bullets, bulletspeed, bulletrange1, bulletrange2, bulletside)

func fire_auto():
	var bulletspeed = 13
	var bulletrange1 = 0.075
	var bulletrange2 = -0.075
	shoot.emit(self.name, get_node("BulletDir" + str(bulletside)).get_global_position(), side, bullets, bulletspeed, bulletrange1, bulletrange2, bulletside)

func alert_death(dmg):
	pass
	#health -= dmg
	#print(str(health) + " " + str(dmg))
