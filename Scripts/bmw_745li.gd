extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Eisenach Monarch"
var country := "Germany"
var engine := "V8 4.4L"
var weight_kg := 1985
var zero_to_hundred_display := 6.40

func _ready():
	# GAMEPLAY STATS
	mass = 1985.0
	horsepower = 325
	max_rpm = 6200.0
	zero_to_hundred = 6.4
	top_speed_kmh = 265
	turn_speed = 2.35
	brake_strength = 10.2
	lateral_friction = 1.02
	transmission = "Rear wheel drive"

	# E66 745Li 5-speed auto (realistic ratios)
	gear_count = 6
	gear_ratios = [
		4.17,  # 1st - strong launch torque
		2.34,  # 2nd - smooth pull
		1.52,  # 3rd - main acceleration gear
		1.14,  # 4th - highway merge
		0.87,  # 5th - high-speed cruising
		0.69   # 6th - overdrive for 265 km/h
	]

	# SHIFT LOGIC (luxury V8 behavior)
	shift_up_rpm = 6000
	shift_down_rpm = 1800

	apply_stats()
	print("Child READY loaded:", def_car_name)
