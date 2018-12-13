extends Label

func _ready():
	GameState.connect("scored", self, "_on_ScoreCounter_scored")

func _on_ScoreCounter_scored(new_score):
	text = str(new_score)