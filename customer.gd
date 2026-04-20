extends Node2D

@onready var anim = $AnimationPlayer
@onready var scaler = $Move/Scale
@onready var sprite = $Move/Scale/Sprite2D

var target = Vector2.ZERO
var light = 0.0
var leaving = false

func _process(delta: float) -> void:
	if leaving:
		if !anim.is_playing():
			queue_free()
	else:
		sprite.material.set_shader_parameter("light", light)
		if target.distance_squared_to(position) > 0.5:
			anim.play("Walk")
		else:
			anim.play("Idle")

func set_texture(tex):
	sprite.texture = tex
	scaler.scale = Vector2.ONE * (200.0 / tex.get_width())

func leave_line():
	leaving = true
	anim.play("Leave")
