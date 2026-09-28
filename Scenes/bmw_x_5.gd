extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Eisenach Escorter"
var country := "Germany"
var engine := "V8 4.4L"
var weight_kg := 2250
var zero_to_hundred_display := 6.90

func _ready():
	# GAMEPLAY STATS
	mass = 2250.0
	horsepower = 315
	max_rpm = 6000.0
	zero_to_hundred = 6.7
	top_speed_kmh = 240
	turn_speed = 2.05              # tighter, premium BMW SUV steering
	brake_strength = 15.2          # strong German brakes
	lateral_friction = 1.08        # AWD grip with BMW road bias
	transmission = "Four wheel drive"

	# BMW 4.4i-style gearing (smooth, long-legged, highway-ready)
	gear_count = 6
	gear_ratios = [
		3.91,  # 1st - strong V8 launch
		2.20,  # 2nd
		1.52,  # 3rd
		1.14,  # 4th
		0.92,  # 5th
		0.78   # 6th - relaxed autobahn overdrive
	]
	shift_up_rpm = 5600
	shift_down_rpm = 2200

	is_diesel = false

	# APPLY STATS + HANDLING
	apply_stats()

	print("Child READY loaded:", def_car_name)
