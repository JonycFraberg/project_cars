extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Colossus Titan Max"
var country := "USA"
var engine := "V8 6.5L"
var weight_kg := 3500
var zero_to_hundred_display := 13.50

func _ready():
	# GAMEPLAY STATS
	mass = 3500.0
	horsepower = 195
	max_rpm = 3400.0
	zero_to_hundred = 15.0
	top_speed_kmh = 180
	turn_speed = 1.4
	brake_strength = 9.0
	lateral_friction = 0.92
	transmission = "Four wheel drive"

	# H1-style gearing (torque-heavy, low-speed grunt)
	gear_count = 4
	gear_ratios = [2.48, 1.48, 1.00, 0.75]
	shift_up_rpm = 3200
	shift_down_rpm = 1500

	# DISTINCT HANDLING PROFILE
	
	is_diesel=true

	# APPLY STATS + HANDLING
	apply_stats()
	

	print("Child READY loaded:", def_car_name)
