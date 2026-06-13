extends Node2D

@onready var anim = $AnimationPlayer

signal score_changed(new_score)
signal lives_changed(new_lives)

var score = 0
var lives = 5
var game_is_over = false
var spare_customers = 0

func _ready() -> void:
	Static.game = self
	anim.play("start")
	await anim.animation_finished
	print("finished")

func add_score(points):
	if !game_is_over:
		score += points
		score_changed.emit(score)

func take_life():
	if lives > 0:
		lives -= 1
		lives_changed.emit(lives)
	else:
		if !game_is_over:
			game_is_over = true
			Static.customers.game_over()
			Static.game_over_screen.game_over()
