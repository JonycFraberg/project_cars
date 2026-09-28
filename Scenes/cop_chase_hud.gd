extends CanvasLayer

@onready var crosshair := $Control/CrosshairDraw
@onready var timer_label := $Control/TimerLabel
@onready var lock_label := $Control/EMPLockLabel
@onready var captured_label := $Control/CapturedLabel
@onready var time_left_label := $Control/TimeLeftLabel

# ============================
# EMP HUD CONTROL
# ============================

func update_emp_lock_progress(seconds: float, required: float):
	# Update the Node2D ring
	crosshair.set_lock_progress(seconds, required)

	# Update the timer label (live lock time)
	timer_label.text = str(snapped(seconds, 0.1)) + "s"
	timer_label.visible = true

	# Hide final lock label while locking
	lock_label.visible = false


func emp_lock_lost():
	# Clear visuals
	crosshair.clear_lock()
	timer_label.visible = false
	lock_label.visible = false


func emp_fired(final_seconds: float):
	# Flash effect
	crosshair.emp_fired()

	# Hide live timer
	timer_label.visible = false

	# Show final lock time
	lock_label.text = "Locked: " + str(snapped(final_seconds, 0.1)) + "s"
	lock_label.visible = true


# ============================
# CAPTURED COUNTER
# ============================

func update_captured(current: int, total: int):
	captured_label.text = str(current) + "/" + str(total)


# ============================
# TIME LEFT COUNTER
# ============================

func update_time_left(seconds: float):
	var mins = int(seconds) / 60
	var secs = int(seconds) % 60
	time_left_label.text = str(mins) + ":" + str(secs).pad_zeros(2)
