extends Area2D

const reward = 10
const fade_time = 0.5
const fall_velocity = 600

func _ready():
	set_process(true)

func _process(delta):
	global_position.y += fall_velocity*delta

func _on_Vase_area_entered(area):
	print("area entered")
	if area.is_in_group("player"):
		set_process(false)
		GameState.score += reward
		$FadeTween.interpolate_property(self, "modulate:a", 1.0, 0.0, fade_time, Tween.TRANS_EXPO, Tween.EASE_OUT)
		$FadeTween.start()

func _on_FadeTween_tween_completed(object, key):
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()