extends CharacterBody2D

signal shoot
var screen_size
var target_velocity = Vector2.ZERO
var gravity = 400
var side = "Enemy"
var health = 100
func _ready():
	screen_size = get_viewport_rect().size
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if health <= 0:
		self.queue_free()
	velocity = target_velocity
	if not is_on_floor():
		velocity.y += gravity
	move_and_slide()
	shoot.emit(self.name, get_parent().get_node("Player").global_position, side)
func alert_death(dmg):
	health -= dmg
