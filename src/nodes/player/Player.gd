extends Node2D

const swipe_duration = 1.5
const rot_duration = 0.5
export var swipe_color = Color()

var cur_mouse_pos = Vector2()

func _ready():
	set_process_input(true)

func _input(event):
	if event is InputEventMouseMotion:
		cur_mouse_pos = event.global_position
	elif event.is_action_released("g_target") and not $Trail/DimTween.is_active():
		get_node("Knife").stop_falling()
		$Trail.make_trail($Knife.global_position, cur_mouse_pos)
		swipe(cur_mouse_pos)

func swipe(in_pos):
	$SwipeTween.interpolate_property($Knife, "position", $Knife.position, position + in_pos, swipe_duration, Tween.TRANS_QUINT, Tween.EASE_OUT)
	$RotationTween.interpolate_property($Knife, "rotation_degrees", $Knife.rotation_degrees, rad2deg($Knife.global_position.angle_to_point(in_pos))+180.0, rot_duration, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$SwipeTween.start()
	$RotationTween.start()