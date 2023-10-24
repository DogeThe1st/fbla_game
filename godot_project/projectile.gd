extends Area2D

var velocity
var dmg = 5
var speed
var side
var game = true
var paused : bool = false
func _process(_delta):
	game = get_parent().game
	paused = get_parent().paused
	if game == true and paused == false:
		move_local_x(speed)
func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()


func _on_body_entered(body):
	if "side" in body:
		if body.side != self.side:
			body.alert_death(dmg)
			self.queue_free()
	else:
		self.queue_free()
