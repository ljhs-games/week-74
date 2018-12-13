extends Node2D

const vase_pack = preload("res://nodes/vase/Vase.tscn")
const spawn_times = Vector2(4.0, 8.0)


var cur_spawn_time = spawn_times.y
var spawn_counter = 0.0

func _ready():
	set_process(true)

func _process(delta):
	spawn_counter += delta
	if spawn_counter > cur_spawn_time:
		spawn_vase()
		reset_spawntime()

func spawn_vase():
	var cur_vase = vase_pack.instance()
	add_child(cur_vase)
	cur_vase.global_position = Vector2(rand_range(50, 650), -200)

func reset_spawntime():
	spawn_counter = 0.0
	cur_spawn_time = rand_range(spawn_times.x, spawn_times.y)