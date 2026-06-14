extends CanvasLayer

@onready var anim = $AnimationPlayer

@onready var score_l = $Control/Score
@onready var served_l = $Control/Served
@onready var time_l = $Control/Time

func _ready() -> void:
	Static.game_over_screen = self

func game_over():
	show()
	anim.play("game_over")
	score_l.text += str(Static.game.score)
	served_l.text += str(Static.game.served)
	time_l.text += Static.game.get_played_time_string()

func _on_back_to_menu_pressed() -> void:
	anim.play("fade_out")
	await anim.animation_finished
	Static.main_menu.stop_game()

func _on_restart_pressed() -> void:
	anim.play("fade_out")
	await anim.animation_finished
	Static.main_menu.restart_game()
