extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Linetti Shepherd"
var country := "Italy"
var engine := "V10 5.0L"
var weight_kg := 1430
var zero_to_hundred_display := 4.20

func _ready():
	# PERFORMANCE
	mass = 1430.0
	horsepower = 500
	max_rpm = 8200.0
	zero_to_hundred = 4.2
	top_speed_kmh = 305

	# HANDLING
	turn_speed = 2.95
	brake_strength = 14.2
	lateral_friction = 1.20


	# DRIVETRAIN
	transmission = "Four wheel drive"
	gear_count = 6
	gear_ratios = [
		3.36,  # 1st - strong AWD launch
		2.05,  # 2nd
		1.43,  # 3rd
		1.12,  # 4th
		0.94,  # 5th
		0.78   # 6th - enough for 305 km/h
	]
	shift_up_rpm = 8000
	shift_down_rpm = 3500

	apply_stats()
	print("Child READY loaded:", def_car_name)
