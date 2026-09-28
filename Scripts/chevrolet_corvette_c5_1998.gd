extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Brutus Stingray"
var country := "USA"
var engine := "V8 6.0L"
var weight_kg := 1460
var zero_to_hundred_display := 5.00

func _ready():
	# GAMEPLAY STATS
	mass = 1460.0
	horsepower = 340
	max_rpm = 6000.0
	zero_to_hundred = 5.0
	top_speed_kmh = 256
	turn_speed = 2.85
	brake_strength = 12.8
	lateral_friction = 1.10
	transmission = "Rear wheel drive"

	# Corvette C5-style handling (light nose, playful RWD, stable at speed)
	

	# GM 6-speed manual (shorter gears, aggressive acceleration)
	gear_count = 6
	gear_ratios = [
		3.36,  # 1st - strong launch
		2.07,  # 2nd
		1.43,  # 3rd
		1.00,  # 4th
		0.84,  # 5th
		0.56   # 6th - long overdrive for top speed
	]
	shift_up_rpm = 5800
	shift_down_rpm = 2200

	apply_stats()
	print("Child READY loaded:", def_car_name)
