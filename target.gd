extends Area2D

@onready var customers = $"../Customers"

func _on_body_entered(body: Node2D) -> void:
	body.collect()
	customers.remove_customer()
	Static.game.add_score(100) # TODO: take score from food items
