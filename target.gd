extends Area2D

@onready var customers = $"../Customers"
@onready var cash_sfx = $CashRegister

func _on_body_entered(body: Node2D) -> void:
	var cust = customers.remove_customer()
	body.collect(cust)
	Static.game.add_score(100) # TODO: take score from food items
	cash_sfx.play()
