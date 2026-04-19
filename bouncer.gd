extends Node2D

@onready var limit = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	global_position.x = get_global_mouse_position().x
	position.y = 0.0
	position.x = clampf(position.x, -limit.width/2.0, limit.width/2.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
