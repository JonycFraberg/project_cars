extends CanvasLayer

@onready var stopwatch_label := $Control/StopwatchLabel
@onready var lap_label := $Control/LapLabel
@onready var pos_label := $Control/PositionLabel
@onready var radar_target := $Control/RadarTargetLabel

# ============================
# NORMAL RACE HUD
# ============================

func update_stopwatch(ms: int) -> void:
	var minutes = ms / 60000
	var seconds = (ms % 60000) / 1000.0
	stopwatch_label.text = "%02d:%05.2f" % [minutes, seconds]

func update_lap(current: int, total: int) -> void:
	var laps_key := Localization.translate("laps")
	lap_label.text = "%s: %d/%d" % [laps_key, current, total]

func update_position(pos: int, total: int) -> void:
	var suffix := "th"
	if pos == 1:
		suffix = "st"
	elif pos == 2:
		suffix = "nd"
	elif pos == 3:
		suffix = "rd"

	pos_label.text = "%d%s/%d" % [pos, suffix, total]

# ============================
# SPEED FORMATTER
# ============================

func format_speed(speed_kmh: float) -> String:
	var use_mph := SpeedSettings.SPEED_UNIT == "mph"

	if use_mph:
		var mph := speed_kmh * 0.621371
		return "%d mph" % mph
	else:
		return "%d km/h" % speed_kmh

# ============================
# RADAR TARGET UPDATE
# ============================

func update_radar_target(speed_kmh: float) -> void:
	var formatted := format_speed(speed_kmh)
	radar_target.text = formatted
