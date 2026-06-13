extends Node2D

@onready var spawnables = [
	#load("res://FoodObjects/beans.tscn"),
	#load("res://FoodObjects/pizza.tscn")
	load("res://FoodObjects/soda.tscn")
]

@onready var food_pattern = {
	"0": {
		"spawnables": [
			{
				"obj": load("res://FoodObjects/beans.tscn"),
				"time": 2000
			},
			{
				"obj": load("res://FoodObjects/pizza.tscn"),
				"time": 3000
			},
		]
	},
	"10000": {
		"spawnables": [
			{
				"obj": load("res://FoodObjects/soda.tscn"),
				"time": 500
			}
		]
	}
}

var next_pick_time = 0
var start_time = 0
var reverse_pattern_keys = []

@onready var throw_sfx = $ThrowSFX
@onready var customers = $"../Customers"
@onready var food_parent = $"../Foods"

func reverse_int_str_sort(a, b):
	if a.to_int() > b.to_int():
		return true
	return false

func pick_food():
	var now = Time.get_ticks_msec()
	for t in reverse_pattern_keys:
		if now - start_time >= t.to_int():
			var s = food_pattern.get(t, {}).get("spawnables", [null])
			return s[randi_range(0, len(s) - 1)]
	
	return null

func _ready() -> void:
	start_time = Time.get_ticks_msec()
	reverse_pattern_keys = food_pattern.keys()
	reverse_pattern_keys.sort_custom(reverse_int_str_sort)

func _physics_process(delta: float) -> void:
	var now = Time.get_ticks_msec()
	if !Static.game.game_is_over and now >= next_pick_time:
		var def = pick_food()
		next_pick_time = now + def.get("time", 2000)
		await get_tree().create_timer(float(def.get("time", 2000))/1000.0).timeout
		if Static.game.game_is_over:
			return
		var obj = def.get("obj").instantiate() # TODO: default here
		food_parent.add_child(obj)
		obj.global_position = global_position
		obj.velocity = Vector2.RIGHT.rotated(deg_to_rad(-obj.start_angle)) * obj.start_speed
		throw_sfx.play()
		if Static.game.spare_customers > 0:
			Static.game.spare_customers -= 1
		else:
			customers.spawn_customer()
