extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Berkshire Persian"
var country := "UK"
var engine := "V8 4.2L"
var weight_kg := 1750
var zero_to_hundred_display := 6.00

func _ready():
	# GAMEPLAY STATS — Refined British executive sedan
	mass = 1750.0
	horsepower = 300
	max_rpm = 6200.0
	zero_to_hundred = 5.7
	top_speed_kmh = 253
	turn_speed = 2.40
	brake_strength = 11.2
	lateral_friction = 1.05
	transmission = "Rear wheel drive"

	# Smooth luxury-sedan handling
	handling_type = "executive_sedan"

	# ZF 6-speed automatic
	gear_count = 6
	gear_ratios = [
		4.17,  # 1st
		2.34,  # 2nd
		1.52,  # 3rd
		1.14,  # 4th
		0.87,  # 5th
		0.69   # 6th
	]

	shift_up_rpm = 5900
	shift_down_rpm = 2200

	apply_stats()
	print("Child READY loaded:", def_car_name)
