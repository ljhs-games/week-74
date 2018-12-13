extends ProgressBar

func _ready():
	min_value = 0.0
	max_value = GameState.max_time
	set_process(true)

func _process(delta):
	GameState.time_left -= delta
	value = GameState.time_left