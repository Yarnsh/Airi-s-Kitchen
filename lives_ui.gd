extends PanelContainer

var connected = false
@onready var label = $Label

func _process(delta: float) -> void:
	if !connected and Static.game != null: # Lazy way to avoid ready timings
		Static.game.lives_changed.connect(lives_changed)
		connected = true

func lives_changed(new_lives):
	label.text = ""
	for i in range(new_lives):
		label.text += "* "
