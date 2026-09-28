extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Linetti Terror"
var country := "Italy"
var engine := "V12 6.2L"
var weight_kg := 1650
var zero_to_hundred_display := 3.80

func _ready():
	# PERFORMANCE
	mass = 1650.0
	horsepower = 580
	max_rpm = 8200.0
	zero_to_hundred = 3.8
	top_speed_kmh = 330

	# HANDLING
	turn_speed = 2.75
	brake_strength = 14.5
	lateral_friction = 1.18
	

	# DRIVETRAIN
	transmission = "Four wheel drive"
	gear_count = 6
	gear_ratios = [
		3.15,  # 1st - heavy AWD launch
		2.10,  # 2nd
		1.55,  # 3rd
		1.20,  # 4th
		0.98,  # 5th
		0.82   # 6th - enough for 330 km/h
	]
	shift_up_rpm = 8000
	shift_down_rpm = 3500

	apply_stats()
	print("Child READY loaded:", def_car_name)
