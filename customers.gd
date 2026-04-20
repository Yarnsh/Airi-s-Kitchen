extends Node2D

@onready var customer_prefab = load("res://customer.tscn")

var customer_imgs = []
var queue = []

@onready var add_below_this = $AddBelowThis
@onready var path = $Path2D

func _ready() -> void:
	var customer_pngs = Static.get_all_file_paths("res://Customers")
	for png in customer_pngs:
		if png.ends_with(".import"):
			continue
		var image = load(png)
		customer_imgs.append(image)

func _process(delta: float) -> void:
	for idx in range(len(queue)):
		var target = min(500.0, idx * (70.0 - (idx)*5.0))
		queue[idx].scale = Vector2.ONE * (1.0 - min(queue[idx].position.length(), 450.0)/450.0)
		queue[idx].light = 1.0 - min(queue[idx].position.length(), 100.0)/100.0
		queue[idx].target = path.curve.sample_baked(target)
		queue[idx].position = queue[idx].position.move_toward(path.curve.sample_baked(target), delta * 200.0)

func spawn_customer():
	var customer = customer_prefab.instantiate()
	add_below_this.add_sibling(customer)
	customer.set_texture(customer_imgs[randi_range(0, len(customer_imgs)-1)])
	customer.position = path.curve.sample_baked(500.0)
	queue.append(customer)

func remove_customer():
	if len(queue) > 0:
		queue[0].leave_line()
		queue.pop_front()
