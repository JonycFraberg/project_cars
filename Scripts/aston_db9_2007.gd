extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Berkshire V12-S"
var country := "UK"
var engine := "V12 5.9L"
var weight_kg := 1740
var zero_to_hundred_display := 5.10

func _ready():
	# GAMEPLAY STATS
	mass = 1740.0
	horsepower = 450
	max_rpm = 6500.0
	zero_to_hundred = 5.1
	top_speed_kmh = 296
	turn_speed = 2.70
	brake_strength = 13.2
	lateral_friction = 1.08
	transmission = "Rear wheel drive"

	

	# Aston 6-speed automatic (long gears, smooth shifts)
	gear_count = 6
	gear_ratios = [
		3.15,  # 1st - strong GT launch
		2.18,  # 2nd
		1.52,  # 3rd
		1.14,  # 4th
		0.87,  # 5th
		0.69   # 6th - overdrive for 300 km/h
	]
	shift_up_rpm = 6200
	shift_down_rpm = 2200

	apply_stats()
	print("Child READY loaded:", def_car_name)
