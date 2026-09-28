extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Colossus Behemoth"
var country := "USA"
var engine := "V8 6.0L"
var weight_kg := 2900
var zero_to_hundred_display := 10.10

func _ready():
	# GAMEPLAY STATS
	mass = 2900.0
	horsepower = 316
	max_rpm = 5200.0
	zero_to_hundred = 10.1
	top_speed_kmh = 198
	turn_speed = 1.8
	brake_strength = 14.0
	lateral_friction = 1.00
	transmission = "Four wheel drive"

	# H2-style gearing (torquey SUV, smoother than H1)
	gear_count = 5
	gear_ratios = [
		3.06,  # 1st
		1.72,  # 2nd
		1.13,  # 3rd
		0.84,  # 4th
		0.70   # 5th
	]
	shift_up_rpm = 4700
	shift_down_rpm = 1800

	# DISTINCT HANDLING PROFILE
	

	# APPLY STATS + HANDLING
	apply_stats()
	

	print("Child READY loaded:", def_car_name)
