extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Bartoli Track Cruiser"
var country := "Italy"
var engine := "V12 6.0L"
var weight_kg := 1335
var zero_to_hundred_display := 3.40

func _ready():
	# PERFORMANCE
	mass = 1335.0
	horsepower = 621
	max_rpm = 8200.0
	zero_to_hundred = 3.4
	top_speed_kmh = 335

	# HANDLING — GT1‑inspired stability
	turn_speed = 2.92              # sharper than road cars, stable at speed
	brake_strength = 15.2          # huge carbon‑ceramic stopping power
	lateral_friction = 1.22        # wide body + aero grip

	# DRIVETRAIN — RWD, long gearing
	transmission = "Rear wheel drive"
	gear_count = 6
	gear_ratios = [
		3.05,  # 1st — strong RWD launch, not AWD brutal
		2.10,  # 2nd
		1.55,  # 3rd
		1.22,  # 4th
		1.00,  # 5th — pulls hard to 300+
		0.82   # 6th — long GT1-style overdrive for 335 km/h
	]

	shift_up_rpm = 8000
	shift_down_rpm = 3600

	apply_stats()
	print("Child READY loaded:", def_car_name)
