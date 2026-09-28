extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Mir Cars Crawler"
var country := "UAE"
var engine := "V8 4.9L"
var weight_kg := 2489
var zero_to_hundred_display := 6.90

func _ready():
	# GAMEPLAY STATS — Fast luxury crossover with strong V8 punch
	mass = 2289.0
	horsepower = 320
	max_rpm = 6000.0
	zero_to_hundred = 6.9
	top_speed_kmh = 226
	turn_speed = 2.15              # tighter, more responsive than heavy SUVs
	brake_strength = 15.0          # strong V8 crossover braking
	lateral_friction = 1.10        # confident AWD road grip
	transmission = "Four wheel drive"

	# V8 luxury‑sport gearing (smooth, punchy, highway‑ready)
	gear_count = 6
	gear_ratios = [
		3.85,  # 1st - strong V8 launch
		2.12,  # 2nd
		1.48,  # 3rd
		1.13,  # 4th
		0.92,  # 5th
		0.78   # 6th - relaxed high‑speed overdrive
	]
	shift_up_rpm = 5600
	shift_down_rpm = 2300

	is_diesel = false

	# APPLY STATS + HANDLING
	apply_stats()

	print("Child READY loaded:", def_car_name)
