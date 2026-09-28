extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Mir Cars Hutch"
var country := "UAE"
var engine := "V8 7.1L"
var weight_kg := 1780
var zero_to_hundred_display := 5.60

func _ready():
	# GAMEPLAY STATS — UAE heritage muscle brute
	mass = 1780.0
	horsepower = 372
	max_rpm = 5600.0              # Big-displacement desert-tuned V8, strong mid-range punch
	zero_to_hundred = 5.6
	top_speed_kmh = 221
	turn_speed = 2.50             # Heavy nose, classic muscle feel
	brake_strength = 12.2         # Strong brakes for a 7.1L heavyweight
	lateral_friction = 1.03       # Good RWD grip for a torque-heavy coupe
	transmission = "Rear wheel drive"

	# Mir Cars 4-Speed Heavy Muscle Gearbox
	# Long gears, massive torque, classic UAE street‑brawler character
	gear_count = 4
	gear_ratios = [
		2.52,  # 1st - brutal torque launch
		1.68,  # 2nd - strong mid-range shove
		1.22,  # 3rd - long pull for highway acceleration
		1.00   # 4th - direct drive for 232 km/h
	]
	shift_up_rpm = 5200
	shift_down_rpm = 2300

	# DISTINCT HANDLING PROFILE — Heavy, loud, desert-bred muscle
	handling_type = "heavy_muscle"

	apply_stats()
	print("Child READY loaded:", def_car_name)
