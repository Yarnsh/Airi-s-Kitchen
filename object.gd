extends Node2D

@export var start_angle = 0.75
@export var start_speed = 300.0

@onready var obj = $Object
@onready var sprite = $Object/Sprite2D
@onready var splat_sprite = $Object/SplatSprite

@onready var bounce_sfx = $BounceSFX
@onready var squash_sfx = $SquashSFX

@export var rot_speed = 0.0
@export var rot_mod = 1.0
var velocity = Vector2.ZERO
var dead = false

func _physics_process(delta: float) -> void:
	if !dead:
		velocity += Vector2.DOWN * 190.0 * delta
		obj.rotate(rot_speed * delta)
		
		global_position += velocity * delta

func bounce(normal):
	var old_vel = velocity
	velocity = -(velocity.reflect(normal))
	
	# prevent bad feeling bounces
	var speed = velocity.length()
	velocity.y = min(-80.0, velocity.y)
	velocity = velocity.normalized() * speed
	
	rot_speed = (1.0 + (velocity.normalized().dot(old_vel.normalized()))) * rot_mod
	rot_speed *= -sign(old_vel.rotated(PI/2.0).dot(velocity))
	
	bounce_sfx.play()

func splat():
	dead = true
	sprite.hide()
	splat_sprite.show()
	obj.rotation = 0.0
	
	squash_sfx.play()

func collect():
	queue_free()
	# TODO: cool collection animation
