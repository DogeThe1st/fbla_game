extends CharacterBody2D

signal shoot
signal right_click
var screen_size
var direction
var jumped = false
var speed = 375
var target_velocity = Vector2.ZERO
var gravity = 400
var left = 0
func _ready():
	screen_size = get_viewport_rect().size
	direction = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(is_on_floor())
	direction = Vector2.ZERO
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("click"):
		shoot.emit()
	if Input.is_action_pressed("right_click"):
		right_click.emit()
	direction = direction.normalized()
	target_velocity.x = direction.x * speed
	target_velocity.y = direction.y * speed
	if Input.is_action_pressed("up"):
		if jumped == false:
			left = 7
			jumped = true
	if left > 0:
		target_velocity.y -= 1000
		left -= 1
	velocity = target_velocity
	if not is_on_floor():
		velocity.y += gravity
		jumped = true
	else:
		jumped = false
		left = 0
	move_and_slide()
