extends Node2D

const zombie_pack = preload("res://nodes/zombie/Zombie.tscn")
const spawn_times = Vector2(0.5, 2.0)

var cur_spawn_time = spawn_times.y
var spawn_counter = 0.0

func _ready():
	set_process(true)

func _process(delta):
	spawn_counter += delta
	if spawn_counter > cur_spawn_time:
		spawn_zombie()
		reset_spawntime()

func spawn_zombie():
	var cur_zombie = zombie_pack.instance()
	add_child(cur_zombie)
	cur_zombie.global_position = Vector2(rand_range(50, 650), -200)
	if cur_zombie.global_position.x > 350:
		cur_zombie.flip_h = true

func reset_spawntime():
	spawn_counter = 0.0
	cur_spawn_time = rand_range(spawn_times.x, spawn_times.y)