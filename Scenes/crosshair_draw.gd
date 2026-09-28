extends Node2D

var show_crosshair := false
var lock_progress := 0.0
var lock_required := 5.0
var fired := false

func set_lock_progress(p: float, req: float):
	lock_progress = p
	lock_required = req
	show_crosshair = true
	fired = false
	queue_redraw()

func clear_lock():
	show_crosshair = false
	lock_progress = 0.0
	fired = false
	queue_redraw()

func emp_fired():
	fired = true
	show_crosshair = false
	queue_redraw()

func _draw():
	var center := get_viewport_rect().size / 2

	if show_crosshair:
		_draw_crosshair(center)
		_draw_lock_circle(center)

	if fired:
		_draw_emp_flash(center)


func _draw_crosshair(center):
	var size := 20
	var thickness := 3
	var color := Color(0.2, 0.8, 1.0)

	draw_line(center + Vector2(-size, 0), center + Vector2(size, 0), color, thickness)
	draw_line(center + Vector2(0, -size), center + Vector2(0, size), color, thickness)


func _draw_lock_circle(center):
	var radius := 40
	var color := Color(0.2, 0.8, 1.0)
	var angle := (lock_progress / lock_required) * TAU

	draw_arc(center, radius, 0, angle, 64, color, 4)


func _draw_emp_flash(center):
	var radius := 80
	var color := Color(0.2, 0.8, 1.0, 0.4)
	draw_circle(center, radius, color)
