extends Area2D

@export var normal = Vector2.LEFT

func bounce(body):
	body.wall_bounce(normal.normalized())

func _on_body_entered(body: Node2D) -> void:
	bounce(body)

func _physics_process(delta: float) -> void:
	for b in get_overlapping_bodies():
		bounce(b)
