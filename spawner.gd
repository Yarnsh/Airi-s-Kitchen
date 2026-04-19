extends Node2D

@onready var spawnables = [
	load("res://FoodObjects/beans.tscn"),
	load("res://FoodObjects/pizza.tscn")
]

var spawn_delay = 2000
var next_spawn = 0

@onready var throw_sfx = $ThrowSFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_spawn = Time.get_ticks_msec() + 1000

func _physics_process(delta: float) -> void:
	var now = Time.get_ticks_msec()
	if now >= next_spawn:
		var spawn_id = randi_range(0, len(spawnables) - 1)
		var obj = spawnables[spawn_id].instantiate()
		get_parent().add_child(obj)
		obj.global_position = global_position
		obj.velocity = Vector2.RIGHT.rotated(-obj.start_angle) * obj.start_speed
		throw_sfx.play()
		next_spawn += spawn_delay
