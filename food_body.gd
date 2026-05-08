extends CharacterBody2D

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
