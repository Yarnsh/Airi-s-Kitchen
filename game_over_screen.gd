extends CanvasLayer

@onready var anim = $AnimationPlayer

func _ready() -> void:
	Static.game_over_screen = self

func game_over():
	show()
	anim.play("game_over")

func _on_back_to_menu_pressed() -> void:
	anim.play("fade_out")
	await anim.animation_finished
	Static.main_menu.stop_game()

func _on_restart_pressed() -> void:
	anim.play("fade_out")
	await anim.animation_finished
	Static.main_menu.restart_game()
