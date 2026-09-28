extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kestrel Battleaxe"
var country := "UK"
var engine := "V6 4.0L"
var weight_kg := 1078
var zero_to_hundred_display := 3.50

func _ready():
	# PERFORMANCE
	mass = 1078.0
	horsepower = 406
	max_rpm = 7800.0
	zero_to_hundred = 3.5
	top_speed_kmh = 287

	# HANDLING
	turn_speed = 3.25
	brake_strength = 13.8
	lateral_friction = 1.16
	

	# DRIVETRAIN
	transmission = "Rear wheel drive"
	gear_count = 5
	gear_ratios = [
		3.10,  # 1st - violent launch
		2.15,  # 2nd
		1.55,  # 3rd
		1.18,  # 4th
		0.92   # 5th - enough for 298 km/h
	]
	shift_up_rpm = 7600
	shift_down_rpm = 3000

	apply_stats()
	print("Child READY loaded:", def_car_name)
	
