extends Area2D

var velocity
var dmg = 5
var rng = RandomNumberGenerator.new()
var speed = rng.randf_range(8, 12)
var side

func _process(_delta):
	#print(speed)
	move_local_x(speed)
	#print(side)
func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()


func _on_body_entered(body):
	if "side" in body:
		if body.side != self.side:
			body.alert_death(dmg)
			self.queue_free
