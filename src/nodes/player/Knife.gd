extends Area2D

const fall_velocity = 50.0
const fall_time = 2.0

var cur_fall = 0.0

func start_falling():
	set_process(true)

func stop_falling():
	set_process(false)
	cur_fall = 0.0
	$Sprite.modulate.a = 1.0

func _process(delta):
	cur_fall += delta
	$Sprite.modulate.a = (cur_fall / fall_time)*-1 + 1
	global_position.y += fall_velocity * delta
	if cur_fall > fall_time:
		GameState.dead = true
		set_process(false)