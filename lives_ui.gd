extends PanelContainer

var connected = false
@onready var lives = [
	$HBoxContainer/Life1,
	$HBoxContainer/Life2,
	$HBoxContainer/Life3,
	$HBoxContainer/Life4,
	$HBoxContainer/Life5
]

func _process(delta: float) -> void:
	if !connected and Static.game != null: # Lazy way to avoid ready timings
		Static.game.lives_changed.connect(lives_changed)
		connected = true

func lives_changed(new_lives):
	for i in range(5):
		if i >= new_lives:
			lives[i].lose_life()
