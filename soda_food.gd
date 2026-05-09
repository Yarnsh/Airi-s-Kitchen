extends Node2D

@export var start_angle = 45
@export var start_speed = 300.0
@export var gravity = 190.0

@onready var obj = $Object
@onready var sprite = $Object/Sprite2D
@onready var splat_sprite = $Object/SplatSprite
@onready var particles = $Object/GPUParticles2D

@onready var bounce_sfx = $BounceSFX
@onready var squash_sfx = $SquashSFX
@onready var hiss_sfx = $HissSFX

@export var rot_speed = 0.0
@export var rot_mod = 1.0
var velocity = Vector2.ZERO
var fizzing = false
var fizz_accel = 250.0
var dead = false

var follow_customer = null

func _physics_process(delta: float) -> void:
	if !dead:
		velocity += Vector2.DOWN * gravity * delta
		if fizzing:
			velocity += obj.global_transform.y * fizz_accel * delta
		obj.rotate(rot_speed * delta)
		
		global_position += velocity * delta
	elif follow_customer != null:
		global_position = global_position.move_toward(follow_customer.move.global_position, 800.0 * delta)
		rotation = move_toward(rotation, 0.0, delta)
	else:
		pass

func bounce(normal):
	if not fizzing:
		fizzing = true
		particles.emitting = true
		hiss_sfx.play()
	
	var old_vel = velocity
	velocity = -(velocity.reflect(normal))
	
	# prevent bad feeling bounces
	var speed = velocity.length()
	velocity.y = min(-80.0, velocity.y)
	velocity = velocity.normalized() * speed
	
	rot_speed = (1.0 + (velocity.normalized().dot(old_vel.normalized()))) * rot_mod
	rot_speed *= -sign(old_vel.rotated(PI/2.0).dot(velocity))
	
	bounce_sfx.play()

func wall_bounce(normal):
	var old_vel = velocity
	velocity = -(velocity.reflect(normal))
	
	# prevent bad feeling bounces
	var speed = velocity.length()
	velocity = velocity.normalized() * speed
	
	rot_speed = (1.0 + (velocity.normalized().dot(old_vel.normalized()))) * rot_mod
	rot_speed *= -sign(old_vel.rotated(PI/2.0).dot(velocity))
	
	bounce_sfx.play()

func splat():
	dead = true
	obj.collision_layer = 0
	sprite.hide()
	splat_sprite.show()
	particles.emitting = false
	obj.rotation = 0.0
	
	squash_sfx.play()

func collect(customer):
	dead = true
	particles.emitting = false
	obj.collision_layer = 0
	follow_customer = customer
	if follow_customer != null:
		follow_customer.following_food = self

func eaten():
	remove()
	# TODO: crumb particles or something here instead

func remove():
	# Same as eaten, but without visual effects
	dead = true
	obj.collision_layer = 0
	particles.emitting = false
	queue_free()
