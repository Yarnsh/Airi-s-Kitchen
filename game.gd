extends Node2D

signal score_changed(new_score)
signal lives_changed(new_lives)

var score = 0
var lives = 5
var spare_customers = 0

func _ready() -> void:
	Static.game = self

func add_score(points):
	score += points
	score_changed.emit(score)

func take_life():
	if lives > 0:
		lives -= 1
		lives_changed.emit(lives)
	else:
		pass # TODO: game over stuff
