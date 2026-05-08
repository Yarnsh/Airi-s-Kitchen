extends Area2D

@onready var sfx = $AudioStreamPlayer

func _on_body_entered(body: Node2D) -> void:
	body.remove()
	Static.game.spare_customers += 1
	Static.game.take_life()
	sfx.play()
	# TODO: animate Airi
