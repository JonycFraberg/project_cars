extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Brutus Viper"
var country := "USA"
var engine := "V8 7.0L"
var weight_kg := 1650
var zero_to_hundred_display := 5.80

func _ready():
	# GAMEPLAY STATS
	mass = 1650.0
	horsepower = 355
	max_rpm = 6000.0
	zero_to_hundred = 5.8
	top_speed_kmh = 216
	turn_speed = 2.65
	brake_strength = 12.8
	lateral_friction = 1.06
	transmission = "Rear wheel drive"

	# Shelby GT500 handling (heavy nose, big torque, classic muscle feel)
	

	# 4‑speed muscle car gearing (long, torque-focused)
	gear_count = 4
	gear_ratios = [
		2.78,  # 1st - big torque launch
		1.93,  # 2nd
		1.36,  # 3rd
		1.00   # 4th - direct drive for 241 km/h
	]
	shift_up_rpm = 5600
	shift_down_rpm = 2400

	apply_stats()
	print("Child READY loaded:", def_car_name)
