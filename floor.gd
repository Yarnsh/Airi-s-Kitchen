extends Area2D

@onready var customers = $"../Customers"

func _on_body_entered(body: Node2D) -> void:
	body.splat()
	customers.remove_customer()
	Static.game.take_life()
