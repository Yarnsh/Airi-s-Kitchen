extends PanelContainer

var connected = false
@onready var label = $Label

func _process(delta: float) -> void:
	if !connected and Static.game != null: # Lazy way to avoid ready timings
		Static.game.score_changed.connect(score_changed)
		connected = true

func score_changed(new_score):
	label.text = str(new_score)
