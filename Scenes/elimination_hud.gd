extends CanvasLayer

@onready var timer_label := $Control/TimerLabel
@onready var pos_label := $Control/PositionLabel

# ============================
# ELIMINATION HUD
# ============================

func update_elimination_timer(time_left: float) -> void:
	timer_label.text = "ELIMINATION IN: " + str(int(ceil(time_left)))

func update_position(pos: int, total: int) -> void:
	var suffix := "th"
	if pos == 1: suffix = "st"
	elif pos == 2: suffix = "nd"
	elif pos == 3: suffix = "rd"
	pos_label.text = "%d%s/%d" % [pos, suffix, total]

func show_finish_flash() -> void:
	if has_node("FinishFlash"):
		$FinishFlash.flash()
