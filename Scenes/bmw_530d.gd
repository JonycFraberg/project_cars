extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Eisenach Suppressor"
var country := "Germany"
var engine := "V8 4.8L Naturally Aspirated"
var weight_kg := 1735
var zero_to_hundred_display := 5.50

func _ready():
	# GAMEPLAY STATS
	mass = 1735.0
	horsepower = 367
	max_rpm = 6500.0
	zero_to_hundred = 5.1
	top_speed_kmh = 250
	turn_speed = 2.70
	brake_strength = 13.2
	lateral_friction = 1.08
	transmission = "Rear wheel drive"

	# E60 550i 6-speed automatic
	gear_count = 6
	gear_ratios = [
		4.17, # 1st
		2.34, # 2nd
		1.52, # 3rd
		1.14, # 4th
		0.87, # 5th
		0.69  # 6th
	]

	# SHIFT LOGIC (high-revving V8)
	shift_up_rpm = 6200
	shift_down_rpm = 2000
	is_diesel = false

	apply_stats()
	print("Child READY loaded:", def_car_name)
