extends CharacterBody2D

@export var food_data = {
	"points": 100,
	"snail_points": 10,
	"salty": false,
	"snail_eat_time": 2000
}

@onready var parent = get_parent()
@onready var bounce_anim = $AnimationPlayer

func bounce(normal):
	if parent.velocity.y > 0.0:
		parent.bounce(normal)
		bounce_anim.play("Bounce")

func wall_bounce(normal):
	if parent.velocity.dot(normal) < 0.0:
		parent.wall_bounce(normal)
		bounce_anim.play("Bounce")

func splat():
	parent.splat()

func collect(customer):
	parent.collect(customer)

func eaten():
	parent.eaten()

func remove():
	parent.remove()
