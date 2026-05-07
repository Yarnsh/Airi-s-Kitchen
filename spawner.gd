extends Node2D

@onready var spawnables = [
	load("res://FoodObjects/beans.tscn"),
	load("res://FoodObjects/pizza.tscn")
]

var spawn_delay = 2000
var next_spawn = 0

@onready var throw_sfx = $ThrowSFX
@onready var customers = $"../Customers"
@onready var food_parent = $"../Foods"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_spawn = Time.get_ticks_msec() + 1000

func _physics_process(delta: float) -> void:
	var now = Time.get_ticks_msec()
	if now >= next_spawn:
		var spawn_id = randi_range(0, len(spawnables) - 1)
		var obj = spawnables[spawn_id].instantiate()
		food_parent.add_child(obj)
		obj.global_position = global_position
		obj.velocity = Vector2.RIGHT.rotated(deg_to_rad(-obj.start_angle)) * obj.start_speed
		throw_sfx.play()
		if Static.game.spare_customers > 0:
			Static.game.spare_customers -= 1
		else:
			customers.spawn_customer()
		next_spawn += spawn_delay
