extends Area2D

@onready var customers = $"../Customers"
@onready var cash_sfx = $CashRegister

func _on_body_entered(body: Node2D) -> void:
	body.collect()
	customers.remove_customer()
	Static.game.add_score(100) # TODO: take score from food items
	cash_sfx.play()
