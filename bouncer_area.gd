extends Area2D

func bounce(body):
	var dir = body.global_position - global_position
	body.bounce(dir.normalized())

func _on_body_entered(body: Node2D) -> void:
	bounce(body)

func _physics_process(delta: float) -> void:
	for b in get_overlapping_bodies():
		bounce(b)
