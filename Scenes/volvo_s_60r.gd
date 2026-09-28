extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Strandberg Turbo"
var country := "Sweden"
var engine := "L5 2.5L"
var weight_kg := 1667
var zero_to_hundred_display := 5.9

func _ready():
	# GAMEPLAY STATS
	mass = 1667.0
	horsepower = 300
	max_rpm = 6500.0
	zero_to_hundred = 5.8
	top_speed_kmh = 247
	turn_speed = 2.75
	brake_strength = 12.2
	lateral_friction = 1.11
	transmission = "Four wheel drive"

	# DRIVETRAIN & GEARS (AWD turbo sedan behavior)
	gear_count = 6
	gear_ratios = [
		3.20,  # 1st - strong AWD launch
		2.05,  # 2nd - turbo starts waking up
		1.48,  # 3rd - meat of the powerband
		1.13,  # 4th
		0.97,  # 5th
		0.78   # 6th - long enough for 248 km/h
	]
	shift_up_rpm = 6200
	shift_down_rpm = 2800

	apply_stats()
	print("Child READY loaded:", def_car_name)
