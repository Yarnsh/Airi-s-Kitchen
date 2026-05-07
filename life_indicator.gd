extends Control

@onready var open = $Open
@onready var closed = $Closed

func lose_life():
	open.hide()
	closed.show()
