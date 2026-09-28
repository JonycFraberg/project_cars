extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Linetti Firestorm"
var country := "Italy"
var engine := "V12 5.7L"
var weight_kg := 1625
var zero_to_hundred_display := 4.20

func _ready():
	# GAMEPLAY STATS
	mass = 1625.0
	horsepower = 493
	max_rpm = 7200.0
	zero_to_hundred = 4.2
	top_speed_kmh = 328
	turn_speed = 2.85
	brake_strength = 13.6
	lateral_friction = 1.10
	transmission = "Rear wheel drive"

	# Diablo Roadster handling (90s exotic, wide stance, heavy V12)
	

	# 5‑speed manual (long 90s gearing, huge top speed)
	gear_count = 5
	gear_ratios = [
		2.94,  # 1st - strong V12 launch
		2.06,  # 2nd
		1.43,  # 3rd
		1.09,  # 4th
		0.82   # 5th - long overdrive for 328 km/h
	]
	shift_up_rpm = 6800
	shift_down_rpm = 2600

	apply_stats()
	print("Child READY loaded:", def_car_name)
