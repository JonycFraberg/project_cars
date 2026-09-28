extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kestrel Guillotine"
var country := "UK"
var engine := "V6 4.2L"
var weight_kg := 1100
var zero_to_hundred_display := 3.60

func _ready():
	# PERFORMANCE
	mass = 1100.0
	horsepower = 440
	max_rpm = 8200.0
	zero_to_hundred = 3.6
	top_speed_kmh = 315

	# HANDLING — razor sharp, supercar-tier
	turn_speed = 3.45
	brake_strength = 14.2
	lateral_friction = 1.18
	

	# DRIVETRAIN
	transmission = "Rear wheel drive"
	gear_count = 6
	gear_ratios = [
		3.00,  # 1st - explosive
		2.10,  # 2nd
		1.55,  # 3rd
		1.20,  # 4th
		0.95,  # 5th
		0.78   # 6th - enough for 315 km/h
	]
	shift_up_rpm = 8000
	shift_down_rpm = 3200

	apply_stats()
	print("Child READY loaded:", def_car_name)
