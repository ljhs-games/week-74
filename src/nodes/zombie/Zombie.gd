tool
extends RigidBody2D

export var flip_h = false setget _set_flip_h
const walk_timer = Vector2(1.0, 3.0)
const walk_impulse = 300.0
const stab_impulse = 500.0
const fade_time = 0.5
const pain_times = Vector2(0.2, 0.2)
const max_health = 3

var showing_pain = false
var health = max_health
var cur_walk = 0.0
var cur_walk_max = rand_range(walk_timer.x, walk_timer.y)

func _set_flip_h(new_flip_h):
	flip_h = new_flip_h
	if has_node("AnimatedSprite"):
		$AnimatedSprite.flip_h = !new_flip_h
	

func _ready():
	set_process(true)

func _process(delta):
	cur_walk += delta
	if cur_walk >= cur_walk_max:
		cur_walk = 0.0
		apply_impulse(Vector2(), Vector2((int(flip_h)*-2 + 1)*walk_impulse, 0))

func _on_VisibilityNotifier2D_screen_exited():
	GameState.score += 1
	queue_free()

func die():
	$FadeTween.interpolate_property(self, "modulate:a", 1.0, 0.0, fade_time, Tween.TRANS_QUAD, Tween.EASE_IN)
	$FadeTween.start()

func show_pain():
	$PainTween.interpolate_property(self, "modulate", Color(1,1,1), Color(1,0.5,0.5), pain_times.x, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$PainTween.start()
	showing_pain = true
	

func stab(in_dir):
	health -= 1
	if health == 0:
		die()
	else:
		show_pain()
	print("Stabbed: ", in_dir)
	apply_impulse(Vector2(), Vector2(in_dir.x*stab_impulse, 0))

func _on_FadeTween_tween_completed(object, key):
	GameState.score += max_health
	queue_free()

func _on_PainTween_tween_completed(object, key):
	if showing_pain == true:
		showing_pain = false
	else:
		return
	$PainTween.interpolate_property(self, "modulate", Color(1,0.5,0.5), Color(1,1,1), pain_times.y, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$PainTween.start()