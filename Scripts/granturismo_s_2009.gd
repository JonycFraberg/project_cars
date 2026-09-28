extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Bartoli Cruiser"
var country := "Italy"
var engine := "V8 4.7L"
var weight_kg := 1880
var zero_to_hundred_display := 4.90

func _ready():
	# GAMEPLAY STATS
	mass = 1880.0
	horsepower = 433
	max_rpm = 7200.0
	zero_to_hundred = 4.9
	top_speed_kmh = 287
	turn_speed = 2.75
	brake_strength = 13.4
	lateral_friction = 1.08
	transmission = "Rear wheel drive"

	# Maserati GranTurismo-style handling (smooth GT, slightly softer than DB9/Vanquish)
	

	# ZF 6-speed automatic (GT gearing, longer than Vanquish)
	gear_count = 6
	gear_ratios = [
		3.20,  # 1st - strong GT launch
		2.05,  # 2nd
		1.46,  # 3rd
		1.13,  # 4th
		0.87,  # 5th
		0.66   # 6th - overdrive for 295 km/h
	]
	shift_up_rpm = 6800
	shift_down_rpm = 2200

	apply_stats()
	print("Child READY loaded:", def_car_name)
