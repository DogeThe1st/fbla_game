extends CharacterBody2D

signal shoot
signal right_click
signal die
var screen_size
var direction
var target_velocity = Vector2.ZERO
var health = 1
var game = true
var shifted = 0
@export var move_speed = 305
@export var gravity = 400
@export var jump_force = -600

func _ready():
	screen_size = get_viewport_rect().size
	direction = Vector2.ZERO

func _process(delta):
	if health != 0 and game == true:
		direction = Vector2.ZERO
		if Input.is_action_pressed("left"):
			direction.x -= 1
		if Input.is_action_pressed("right"):
			direction.x += 1
		if Input.is_action_pressed("click"):
			shoot.emit()
		if Input.is_action_pressed("right_click"):
			right_click.emit()
		if Input.is_action_pressed("shift"):
			shifted = 1.5
		else:
			shifted = 1
		direction = direction.normalized()
		target_velocity.x = direction.x * move_speed
		
		if is_on_floor():
			if Input.is_action_pressed("up"):
				target_velocity.y = jump_force
		else:
			target_velocity.y += gravity * delta
		velocity = target_velocity
		move_and_slide()
