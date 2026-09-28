extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Schroder Colosso"
var country := "Germany"
var engine := "V6 3.0L Diesel"
var weight_kg := 2340
var zero_to_hundred_display := 7.80

func _ready():
	# GAMEPLAY STATS
	mass = 2340.0
	horsepower = 237
	max_rpm = 4500.0
	zero_to_hundred = 8.5
	top_speed_kmh = 211
	turn_speed = 1.92              # heavier, premium SUV steering feel
	brake_strength = 14.5          # strong brakes but not sporty
	lateral_friction = 1.04        # premium AWD grip
	transmission = "Four wheel drive"

	# 3.0 TDI-style gearing (torque-rich, smooth, long-legged)
	gear_count = 6
	gear_ratios = [
		3.57,  # 1st - diesel torque launch
		2.10,  # 2nd
		1.46,  # 3rd
		1.06,  # 4th
		0.84,  # 5th
		0.67   # 6th - long highway overdrive
	]
	shift_up_rpm = 4200
	shift_down_rpm = 1700

	is_diesel = true

	# APPLY STATS + HANDLING
	apply_stats()

	print("Child READY loaded:", def_car_name)
