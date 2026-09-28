extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Berkshire Tempest"
var country := "UK"
var engine := "V12 5.9L"
var weight_kg := 1875
var zero_to_hundred_display := 5.40

func _ready():
	# GAMEPLAY STATS
	mass = 1875.0
	horsepower = 520
	max_rpm = 6800.0
	zero_to_hundred = 4.9
	top_speed_kmh = 318
	turn_speed = 2.85
	brake_strength = 13.8
	lateral_friction = 1.10
	transmission = "Rear wheel drive"

	# Aston Martin Vanquish-style handling (sharper GT, more aggressive than DB9)
	

	# Aston 6-speed automatic (slightly shorter gearing than DB9)
	gear_count = 6
	gear_ratios = [
		3.25,  # 1st - strong GT launch
		2.10,  # 2nd
		1.48,  # 3rd
		1.12,  # 4th
		0.86,  # 5th
		0.68   # 6th - overdrive for 303 km/h
	]
	shift_up_rpm = 6400
	shift_down_rpm = 2200

	apply_stats()
	print("Child READY loaded:", def_car_name)
