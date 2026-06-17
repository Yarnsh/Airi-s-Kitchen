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
	return played_time_to_string(get_played_time())
func played_time_to_string(t):
	var h = t / 3600000
	t -= h * 3600000
	var m = t / 60000
	t -= m * 60000
	var s = t / 1000
	t -= s * 1000
	
	var result = ""
	if h > 0:
		result += str(h)+":"
	result += str(m)+":"
	var ss = str(s).pad_zeros(2)
	result += ss+"."
	var ms = str(t).pad_zeros(3)
	result += ms
	
	return result

func take_life():
	if lives > 0:
		lives -= 1
		lives_changed.emit(lives)
	else:
		if !game_is_over:
			game_is_over = true
			end_time = Time.get_ticks_msec()
			update_records()
			Static.customers.game_over()
			Static.game_over_screen.game_over()

func update_records():
	var records = read_records_from_file()
	var current = {
		"score": score,
		"served": served,
		"time": get_played_time(),
		"recorded": Time.get_unix_time_from_system()
	}
	if current.score > records.get("best_score", {}).get("score", -1):
		records["best_score"] = current
	if current.score > records.get("best_served", {}).get("served", -1):
		records["best_served"] = current
	if current.score > records.get("best_time", {}).get("time", -1):
		records["best_time"] = current
	
	write_records_to_file(records)

func write_records_to_file(records):
	var text = JSON.stringify(records)
	var file = FileAccess.open("user://records.dat", FileAccess.WRITE)
	file.store_string(text)

func read_records_from_file():
	var file = FileAccess.open("user://records.dat", FileAccess.READ)
	if file == null:
		return {}
	var content = file.get_as_text()
	var result = JSON.parse_string(content)
	if result == null:
		return {}
	return result
