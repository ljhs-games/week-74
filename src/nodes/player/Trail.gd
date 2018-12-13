extends Node2D

export var color = Color()
const thickness = 2.0
const fade_time = 0.2

var base_pos = Vector2()
var target_pos = Vector2()

func _ready():
	global_position = Vector2()
	modulate.a = 0.0
	set_process(false)

func _process(delta):
	update()

func _draw():
	draw_line(get_node("../Knife").global_position, target_pos, color, thickness, true)

func make_trail(in_base_pos, in_target_pos):
	base_pos = in_base_pos
	target_pos = in_target_pos
	$DimTween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), fade_time, Tween.TRANS_QUAD, Tween.EASE_IN)
	$DimTween.start()
	set_process(true)

func _on_DimTween_tween_completed(object, key):
	$DimTween.stop_all()
	get_node("../Knife").start_falling()
	set_process(false)