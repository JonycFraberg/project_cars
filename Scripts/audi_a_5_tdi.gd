extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Schroder Fastback"
var country := "Germany"
var engine := "V6 3.0L Diesel"
var weight_kg := 1695
var zero_to_hundred_display := 5.60

func _ready():
	# GAMEPLAY STATS
	mass = 1695.0
	horsepower = 242
	max_rpm = 5500.0
	zero_to_hundred = 5.4
	top_speed_kmh = 245
	turn_speed = 2.65
	brake_strength = 18.0
	lateral_friction = 1.18
	transmission = "Four wheel drive"

	is_diesel = true

	# SHIFT LOGIC (diesel = early shifts, fat torque band)
	shift_up_rpm = 4800
	shift_down_rpm = 2000

	# DIESEL QUATTRO GEARING (long legs, high top speed)
	gear_count = 7
	gear_ratios = [
		4.15,  # 1st
		2.31,  # 2nd
		1.55,  # 3rd
		1.14,  # 4th
		0.92,  # 5th
		0.78,  # 6th
		0.67   # 7th (long overdrive for 265 km/h)
	]

	# Diesel quattro handling (torquey, planted, mature)

	apply_stats()
	print("Child READY loaded:", def_car_name)
