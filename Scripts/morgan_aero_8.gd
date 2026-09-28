extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kestrel Speedster"
var country := "UK"
var engine := "V8 4.4L"
var weight_kg := 1145
var zero_to_hundred_display := 4.50

func _ready():
	# GAMEPLAY STATS
	mass = 1145.0
	horsepower = 286
	max_rpm = 6500.0
	zero_to_hundred = 4.7
	top_speed_kmh = 246
	turn_speed = 3.05
	brake_strength = 12.2
	lateral_friction = 1.14
	transmission = "Rear wheel drive"

	# Morgan Aero 8-style handling (ultra-light, twitchy, raw RWD)
	

	# BMW/Morgan 6-speed manual (short, punchy gears)
	gear_count = 6
	gear_ratios = [
		3.38,  # 1st - aggressive lightweight launch
		2.20,  # 2nd
		1.52,  # 3rd
		1.23,  # 4th
		1.00,  # 5th
		0.83   # 6th - mild overdrive
	]
	shift_up_rpm = 6200
	shift_down_rpm = 2400

	apply_stats()
	print("Child READY loaded:", def_car_name)
