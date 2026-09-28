extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Brutus Thunderbolt"
var country := "USA"
var engine := "V10 6.4L"
var weight_kg := 1390
var zero_to_hundred_display := 3.60

func _ready():
	# PERFORMANCE — lighter, sharper than a Viper
	mass = 1390.0
	horsepower = 605
	max_rpm = 6800.0
	zero_to_hundred = 3.6
	top_speed_kmh = 338

	# HANDLING — concept‑car precision with American brutality
	turn_speed = 3.05              # quicker turn‑in than Viper, still heavy RWD feel
	brake_strength = 13.8          # big Brembos, lighter chassis
	lateral_friction = 1.15        # wide stance + modern suspension

	# DRIVETRAIN — RWD, long Ford GT‑style gearing
	transmission = "Rear wheel drive"
	gear_count = 6
	gear_ratios = [
		2.90,  # 1st — violent V10 launch
		1.95,  # 2nd — keeps torque alive
		1.45,  # 3rd
		1.15,  # 4th
		0.92,  # 5th — pulls past 300 km/h
		0.78   # 6th — long overdrive for 338 km/h
	]

	shift_up_rpm = 6500
	shift_down_rpm = 3000

	apply_stats()
	print("Child READY loaded:", def_car_name)
