extends CharacterBody2D

signal shoot
signal right_click
var screen_size
var target_velocity = Vector2.ZERO
var gravity = 400
func _ready():
	screen_size = get_viewport_rect().size
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = target_velocity
	if not is_on_floor():
		velocity.y += gravity
	move_and_slide()
