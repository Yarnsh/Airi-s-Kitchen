extends Control

@onready var game_prefab = load("res://game.tscn")
@onready var game_parent = $GameParent
@onready var anim = $AnimationPlayer

func start_game():
	anim.play("start")
	await anim.animation_finished
	var game = game_prefab.instantiate()
	game_parent.add_child(game)
	anim.play("unfade")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
