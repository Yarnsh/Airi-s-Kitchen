extends FoodObject
@onready var particles = $Object/GPUParticles2D

@onready var hiss_sfx = $HissSFX

var fizzing = false
var fizz_accel = 250.0

func _physics_process(delta: float) -> void:
	if !dead:
		if fizzing:
			velocity += obj.global_transform.y * fizz_accel * delta
	
	super._physics_process(delta)

func bounce(normal):
	if not fizzing:
		fizzing = true
		particles.emitting = true
		hiss_sfx.play()
	
	super.bounce(normal)

func splat():
	particles.emitting = false
	super.splat()

func collect(customer):
	particles.emitting = false
	super.collect(customer)

func remove():
	particles.emitting = false
	super.remove()
