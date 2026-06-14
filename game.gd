extends Node2D

@onready var anim = $AnimationPlayer

signal score_changed(new_score)
signal lives_changed(new_lives)

var score = 0
var served = 0
var start_time = 0
var end_time = -1
var lives = 5
var game_is_over = false
var spare_customers = 0

func _ready() -> void:
	Static.game = self
	anim.play("start")
	start_time = Time.get_ticks_msec()
func add_score(points):
	if !game_is_over:
		score += points
		score_changed.emit(score)
func customer_served():
	served += 1
func get_played_time():
	var et = end_time
	if et < 0:
		et = Time.get_ticks_msec()
	return et - start_time
func get_played_time_string():
	var t = get_played_time()
	var h = t / 3600000
	t -= h * 3600000
	var m = t / 60000
	t -= m * 60000
	var s = t / 1000
	
	var result = ""
	if h > 0:
		result += str(h)+":"
	result += str(m)+":"
	var ss = str(s)
	if len(ss) < 2:
		ss = "0" + ss
	result += ss
	return result

func take_life():
	if lives > 0:
		lives -= 1
		lives_changed.emit(lives)
	else:
		if !game_is_over:
			game_is_over = true
			end_time = Time.get_ticks_msec()
			Static.customers.game_over()
			Static.game_over_screen.game_over()
