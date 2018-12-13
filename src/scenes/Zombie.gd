extends KinematicBody2D

var motion = Vector2()
const speed = 20

func _process(delta):
	var center_position = Vector2(350,250)
	#change to actual center position
	var vector = (position - center_position).normalized()
	motion += vector
	motion = motion * speed * delta
	move_and_collide(motion)
	
func _ready():
	var test_vector = Vector2(350,250)
	#change to player's vector
	speed = speed - test_vector.x