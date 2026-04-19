extends Control

@onready var settings = $Settings

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Menu"):
		visible = !visible
		if !visible:
			settings.save_settings()
