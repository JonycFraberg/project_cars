extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kronstadt Crest"
var country := "Germany"
var engine := "L4 2.1L Diesel"
var weight_kg := 1540
var zero_to_hundred_display := 5.90

func _ready():
	# GAMEPLAY STATS — Mercedes SLK 250 CDI
	mass = 1540.0
	horsepower = 204
	max_rpm = 4500.0              # diesel redline
	zero_to_hundred = 6.2
	top_speed_kmh = 252
	turn_speed = 2.55             # sporty but not twitchy
	brake_strength = 18.5         # heavier car, strong brakes
	lateral_friction = 1.12       # RWD balance
	transmission = "Rear wheel drive"

	# Diesel torque behavior
	is_diesel = true

	# Gear ratios (7G‑Tronic style)
	gear_count = 7
	gear_ratios = [
		4.46,  # 1st - strong diesel launch
		2.61,  # 2nd
		1.72,  # 3rd
		1.26,  # 4th
		1.00,  # 5th
		0.82,  # 6th
		0.73   # 7th - highway overdrive
	]

	shift_up_rpm = 4200
	shift_down_rpm = 1700

	apply_stats()
	print("Child READY loaded:", def_car_name)
