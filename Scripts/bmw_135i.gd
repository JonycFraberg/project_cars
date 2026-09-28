extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Eisenach Bengal"
var country := "Germany"
var engine := "L4 2.0L Twin Turbo Diesel"
var weight_kg := 1550
var zero_to_hundred_display := 6.50

func _ready():
	# GAMEPLAY STATS
	mass = 1550.0
	horsepower = 204
	max_rpm = 5500.0
	zero_to_hundred = 6.5
	top_speed_kmh = 246
	turn_speed = 2.85
	brake_strength = 13.5
	lateral_friction = 1.08
	transmission = "Rear wheel drive"

	# 123d handling (torquey diesel hatch, strong mid-range pull)

	# 6-speed manual inspired gearing
	gear_count = 6
	gear_ratios = [
		4.11,  # 1st
		2.32,  # 2nd
		1.54,  # 3rd
		1.18,  # 4th
		1.00,  # 5th
		0.83   # 6th
	]

	shift_up_rpm = 5200
	shift_down_rpm = 1800
	is_diesel=true

	apply_stats()
	print("Child READY loaded:", def_car_name)
