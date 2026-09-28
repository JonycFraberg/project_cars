extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Berkshire Blunt"
var country := "UK"
var engine := "V8 4.0L Supercharged"
var weight_kg := 1710
var zero_to_hundred_display := 5.40

func _ready():
	# GAMEPLAY STATS
	mass = 1710.0
	horsepower =400
	max_rpm = 6200.0
	zero_to_hundred = 5.6
	top_speed_kmh = 280
	turn_speed = 2.55
	brake_strength = 12.0
	lateral_friction = 1.06
	transmission = "Rear wheel drive"

	# Jaguar XKR coupe GT handling
	handling_type = "luxury_boat"

	# Mercedes 5G-Tronic automatic
	gear_count = 6
	gear_ratios = [
		4.17,  # 1st
		2.34,  # 2nd
		1.52,  # 3rd
		1.14,  # 4th
		0.87,  # 5th
		0.69   # 6th
	]

	shift_up_rpm = 5600
	shift_down_rpm = 2000

	apply_stats()
	print("Child READY loaded:", def_car_name)
