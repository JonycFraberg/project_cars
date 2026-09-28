extends CarController

# ============================
# COSMETIC INFO (UI only)
# ============================
var def_car_name := "Bartoli Interceptor"
var country := "Italy"
var engine := "V8 4.7L"
var weight_kg := 1880
var zero_to_hundred_display := 4.90

# ============================
# EMP SYSTEM
# ============================
var emp_active := false
var emp_target: CarController = null
var emp_range := 45.0
var emp_lock_time := 5.0
var emp_timer := 0.0

var emp_cooldown := 3.0
var emp_cooldown_timer := 0.0


func _ready():
	# Gameplay stats
	mass = 1880.0
	horsepower = 433
	max_rpm = 7200.0
	zero_to_hundred = 4.8
	top_speed_kmh = 292
	turn_speed = 2.75
	brake_strength = 13.4
	lateral_friction = 1.08
	transmission = "Rear wheel drive"

	gear_count = 6
	gear_ratios = [3.20, 2.05, 1.46, 1.13, 0.87, 0.66]
	shift_up_rpm = 6800
	shift_down_rpm = 2200

	apply_stats()
	print("Child READY loaded:", def_car_name)


func _input(event):

	# Add EMP input on top
	if event.is_action_pressed("emp"):
		_start_emp()


func _physics_process(delta):
	# Keep CarController physics (movement, traction, etc.)
	super._physics_process(delta)

	# EMP cooldown
	if emp_cooldown_timer > 0.0:
		emp_cooldown_timer -= delta

	# EMP logic
	if emp_active:
		_process_emp(delta)


func _start_emp():
	if emp_cooldown_timer > 0.0:
		return

	emp_active = true
	emp_timer = 0.0
	emp_target = null

	print("EMP ACTIVATED")


func _process_emp(delta):
	# Acquire target
	if emp_target == null:
		emp_target = _find_emp_target()
		if emp_target == null:
			return

	# Check distance
	var dist := global_position.distance_to(emp_target.global_position)
	if dist > emp_range:
		print("EMP LOCK LOST")

		if CopChaseManager.hud:
			CopChaseManager.hud.emp_lock_lost()

		emp_target = null
		emp_timer = 0.0
		return

	# Count lock time
	emp_timer += delta

	# HUD update
	if CopChaseManager.hud:
		CopChaseManager.hud.update_emp_lock_progress(emp_timer, emp_lock_time)

	# Fire EMP
	if emp_timer >= emp_lock_time:
		_disable_target(emp_target)

		if CopChaseManager.hud:
			CopChaseManager.hud.emp_fired(emp_timer)

		CopChaseManager.capture_racer(emp_target)

		emp_active = false
		emp_timer = 0.0
		emp_target = null
		emp_cooldown_timer = emp_cooldown


func _find_emp_target() -> CarController:
	var nearest: CarController = null
	var nearest_dist := emp_range

	var mgr := CopChaseManager
	if mgr == null:
		return null

	for ai in mgr.ai_cars:
		var d := global_position.distance_to(ai.global_position)
		if d < nearest_dist:
			nearest = ai
			nearest_dist = d

	return nearest

func _disable_target(target: CarController):
	target.controls_enabled = false
	target.hard_frozen = true
	target.velocity = Vector3.ZERO

	print("EMP HIT:", target.car_name)
