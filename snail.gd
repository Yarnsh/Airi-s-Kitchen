extends Area2D

@onready var limit = get_parent()
@onready var foods = $"../../Foods"
@onready var cronch_sfx = $Cronch
@onready var sprite = $Scale/Sprite2D
@onready var eat_mover = $EatMover
@onready var eat_mover2 = $EatMover/EatMover2
@onready var anim = $Anim

var speed = 100.0

var digested_time = 0

func _physics_process(delta: float) -> void:
	if digested_time > Time.get_ticks_msec():
		pass
	else:
		for c in foods.get_children():
			if !c.dead:
				sprite.play("move")
				var food_x = c.global_position.x
				sprite.flip_h = food_x > global_position.x
				if (sprite.flip_h and eat_mover.position.x < 0.0) or (!sprite.flip_h and eat_mover.position.x > 0.0):
					eat_mover.position.x = -eat_mover.position.x
				global_position.x = move_toward(global_position.x, food_x, speed * delta)
				position.x = clampf(position.x, -limit.width/2.0, limit.width/2.0)
				return
		# Idle if we didnt move towards anything
		sprite.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if digested_time < Time.get_ticks_msec():
		digested_time = Time.get_ticks_msec() + body.food_data.get("snail_eat_time", 100) + int(anim.get_animation("eat").length * 1000.0)
		body.eaten(eat_mover2)
		Static.game.spare_customers += 1
		sprite.play("catch")
		
		anim.play("eat")
		await anim.animation_finished
		
		sprite.play("chew")
		body.remove()
		cronch_sfx.play()
		Static.game.add_score(body.food_data.get("snail_points", 10))
