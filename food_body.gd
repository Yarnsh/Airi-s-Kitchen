extends CharacterBody2D

@onready var parent = get_parent()
@onready var bounce_anim = $AnimationPlayer

func bounce(normal):
	if parent.velocity.y > 0.0:
		parent.bounce(normal)
		bounce_anim.play("Bounce")

func splat():
	parent.splat()

func collect(customer):
	parent.collect(customer)
