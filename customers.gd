extends Node2D

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
		var target = min(500.0, idx * 100.0)
		queue[idx].position = queue[idx].position.move_toward(path.curve.sample_baked(target), delta * 200.0)

func spawn_customer():
	# TODO: update this to put them in line behind the others
	var sprite = Sprite2D.new()
	sprite.texture = customer_imgs[randi_range(0, len(customer_imgs)-1)]
	sprite.scale = Vector2.ONE * (200.0 / sprite.texture.get_width())
	sprite.position = path.curve.sample_baked(500.0)
	add_below_this.add_sibling(sprite)
	queue.append(sprite)

func remove_customer():
	if len(queue) > 0:
		queue[0].queue_free()
		queue.pop_front()
