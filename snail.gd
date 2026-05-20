extends Area2D

@onready var limit = get_parent()
@onready var foods = $"../../Foods"
@onready var cronch_sfx = $Cronch
@onready var sprite = $Sprite2D

var speed = 100.0

var digested_time = 0

func _physics_process(delta: float) -> void:
	if digested_time > Time.get_ticks_msec():
		if !sprite.is_playing():
			sprite.play("chew")
	else:
		for c in foods.get_children():
			if !c.dead:
				sprite.play("move")
				var food_x = c.global_position.x
				sprite.flip_h = food_x > global_position.x
				global_position.x = move_toward(global_position.x, food_x, speed * delta)
				position.x = clampf(position.x, -limit.width/2.0, limit.width/2.0)
				return
		# Idle if we didnt move towards anything
		sprite.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if digested_time < Time.get_ticks_msec():
		body.eaten()
		Static.game.spare_customers += 1
		cronch_sfx.play()
		Static.game.add_score(10) # TODO: take score from food items
		digested_time = Time.get_ticks_msec() + 2000 # TODO: take this time from the food item
		sprite.play("catch")
