extends Camera2D

func _ready():
	var MaxLeft = get_parent().get_node("MaxLeft")
	var MaxRight = get_parent().get_node("MaxRight")
	self.limit_left = MaxLeft.global_position.x
	self.limit_right = MaxRight.global_position.x
	
func _physics_process(_delta):
	var player = get_parent().get_node("Player")
	self.global_position.x -= 1
	self.global_position.x = player.global_position.x
