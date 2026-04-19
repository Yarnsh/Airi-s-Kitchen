extends Area2D

func _on_body_entered(body: Node2D) -> void:
	var dir = body.global_position - global_position
	body.bounce(dir.normalized())
