extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Mir Cars Athletic C70"
var country := "USA"
var engine := "V12 7.0L"
var weight_kg := 1378
var zero_to_hundred_display := 3.65

func _ready():
	# PERFORMANCE — American V12 brute
	mass = 1378.0
	horsepower = 600
	max_rpm = 7800.0
	zero_to_hundred = 3.65
	top_speed_kmh = 342

	# HANDLING — heavier, muscular, high‑speed stable
	turn_speed = 2.85              # slightly heavier than MC12, still sharp
	brake_strength = 14.8          # strong brakes for a heavier chassis
	lateral_friction = 1.18        # wide stance, but less aero than GT1 cars

	# DRIVETRAIN — RWD, torque‑biased long gearing
	transmission = "Rear wheel drive"
	gear_count = 6
	gear_ratios = [
		3.10,  # 1st — big V12 launch torque
		2.05,  # 2nd — keeps the torque band alive
		1.50,  # 3rd
		1.20,  # 4th
		0.98,  # 5th — pulls past 300 km/h
		0.80   # 6th — long overdrive for 342 km/h
	]

	shift_up_rpm = 7600
	shift_down_rpm = 3400

	apply_stats()
	print("Child READY loaded:", def_car_name)
