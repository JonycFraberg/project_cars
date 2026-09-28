extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Straeda Pitbull"
var country := "Germany"
var engine := "V10 5.0L"
var weight_kg := 2520
var zero_to_hundred_display := 7.80

func _ready():
	# GAMEPLAY STATS
	mass = 2520.0
	horsepower = 309
	max_rpm = 4500.0
	zero_to_hundred = 7.1
	top_speed_kmh = 235
	turn_speed = 2.0
	brake_strength = 15.0
	lateral_friction = 1.05
	transmission = "Four wheel drive"

	# V10 TDI-style gearing (massive torque, short early gears, long 5th/6th)
	gear_count = 6
	gear_ratios = [
		3.60,  # 1st - huge torque launch
		2.09,  # 2nd
		1.48,  # 3rd
		1.09,  # 4th
		0.83,  # 5th
		0.67   # 6th - long diesel overdrive
	]
	shift_up_rpm = 4300
	shift_down_rpm = 1700
	
	is_diesel=true
	# DISTINCT HANDLING PROFILE
	

	# APPLY STATS + HANDLING
	apply_stats()
	

	print("Child READY loaded:", def_car_name)
