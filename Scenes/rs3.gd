extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Schroder Classique Sport"
var country := "Germany"
var engine := "L4 2.0L Turbo"
var weight_kg := 1420
var zero_to_hundred_display := 4.90

func _ready():
	# GAMEPLAY STATS — Audi TTS (8J)
	mass = 1460.0
	horsepower = 340
	max_rpm = 6800.0
	zero_to_hundred = 5.3
	top_speed_kmh = 265
	turn_speed = 2.95
	brake_strength = 21.0
	lateral_friction = 1.20
	transmission = "Four wheel drive"

	# SHIFT LOGIC — turbo quattro character
	shift_up_rpm = 6500
	shift_down_rpm = 2500

	# TTS QUATTRO GEARING
	gear_count = 6
	gear_ratios = [
		3.36,  # 1st
		2.09,  # 2nd
		1.47,  # 3rd
		1.10,  # 4th
		0.92,  # 5th
		0.76   # 6th
	]

	apply_stats()
	print("Child READY loaded:", def_car_name)
