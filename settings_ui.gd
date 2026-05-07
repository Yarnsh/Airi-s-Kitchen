extends PanelContainer

@onready var canvas = $"../.."
@onready var master_volume = $MarginContainer/All/Options/Controls/Master
@onready var sfx_volume = $MarginContainer/All/Options/Controls/SFX

var last_settings = {}
var ready_done = false

func _ready():
	Static.settings_menu = self
	set_settings_from_dict(read_from_file())
	apply_current_settings()
	last_settings = get_current_settings_dict()
	ready_done = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Menu"):
		canvas.visible = !canvas.visible
		if !canvas.visible:
			save_settings()

func hide_():
	save_settings()
	canvas.hide()
func show_():
	canvas.show()

func get_current_settings_dict():
	return {
		"master_volume": master_volume.value,
		"sfx_volume": sfx_volume.value
	}

func set_settings_from_dict(settings):
	master_volume.value = settings.get("master_volume", 50)
	sfx_volume.value = settings.get("sfx_volume", 50)

func apply_current_settings():
	AudioServer.set_bus_volume_db(0, linear_to_db(float(master_volume.value)/100.0))
	AudioServer.set_bus_volume_db(1, linear_to_db(float(sfx_volume.value)/100.0))

func save_settings():
	last_settings = get_current_settings_dict()
	apply_current_settings()
	write_to_file(last_settings)

func _on_change(value):
	apply_current_settings()

func write_to_file(settings):
	var text = JSON.stringify(settings)
	var file = FileAccess.open("user://settings.dat", FileAccess.WRITE)
	file.store_string(text)

func read_from_file():
	var file = FileAccess.open("user://settings.dat", FileAccess.READ)
	if file == null:
		return {}
	var content = file.get_as_text()
	var result = JSON.parse_string(content)
	if result == null:
		return {}
	return result
