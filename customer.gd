extends Node2D

@onready var anim = $AnimationPlayer
@onready var move = $Move
@onready var scaler = $Move/Scale
@onready var sprite = $Move/Scale/Sprite2D

var target = Vector2.ZERO
var light = 0.0
var leaving = false

var following_food = null

func _process(delta: float) -> void:
	if leaving:
		if !anim.is_playing():
			if following_food != null:
				following_food.queue_free()
			queue_free()
	else:
		sprite.material.set_shader_parameter("light", light)
		if target.distance_squared_to(position) > 0.5 and anim.current_animation == "Idle":
			anim.play("Walk")
			anim.seek(randf_range(0.0, anim.current_animation_length))
		elif target.distance_squared_to(position) <= 0.5 and anim.current_animation == "Walk":
			anim.play("Idle")
			anim.seek(randf_range(0.0, anim.current_animation_length))

func set_texture(tex):
	sprite.texture = tex
	scaler.scale = Vector2.ONE * (200.0 / tex.get_width())

func leave_line():
	leaving = true
	anim.play("Leave")
