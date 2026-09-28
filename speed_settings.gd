extends Node

var SPEED_UNIT: String = "kmh"  # "kmh" or "mph"

func _ready() -> void:
	load_unit()
	print("Loaded speed unit:", SPEED_UNIT)

func set_unit(unit: String) -> void:
	if unit in ["kmh", "mph"]:
		SPEED_UNIT = unit
		save_unit()

func save_unit() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("speed", "unit", SPEED_UNIT)
	cfg.save("user://speed_settings.cfg")

func load_unit() -> void:
	var cfg := ConfigFile.new()
	if cfg.load("user://speed_settings.cfg") == OK:
		var saved: String = cfg.get_value("speed", "unit", "kmh")
		if saved in ["kmh", "mph"]:
			SPEED_UNIT = saved

func convert_speed(kmh: float) -> float:
	if SPEED_UNIT == "mph":
		return kmh * 0.621371
	return kmh

func get_unit_label() -> String:
	return Localization.translate(SPEED_UNIT)
