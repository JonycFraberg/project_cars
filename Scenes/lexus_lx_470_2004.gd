extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Mir Cars Nightwolf"
var country := "UAE"
var engine := "V8 6.0L"
var weight_kg := 2668
var zero_to_hundred_display := 8.90

func _ready():
	# GAMEPLAY STATS — Heavy desert‑bred 4×4
	mass = 2668.0
	horsepower = 220
	max_rpm = 4800.0              # Low‑revving torque monster built for dunes and towing
	zero_to_hundred = 12.0
	top_speed_kmh = 195
	turn_speed = 1.95             # Heavy steering feel; stable but not agile
	brake_strength = 13.0         # Strong brakes needed for a 2.6‑ton chassis
	lateral_friction = 1.02       # Good 4WD grip on pavement and sand
	transmission = "Four wheel drive"

	# Mir Cars Heavy-Duty 5-Speed Gearbox
	# Tuned for torque, dune climbing, and smooth highway cruising
	gear_count = 5
	gear_ratios = [
		3.48,  # 1st - short, brutal torque to move the weight instantly
		2.08,  # 2nd - keeps the Nightwolf in its torque band
		1.42,  # 3rd
		1.00,  # 4th
		0.70   # 5th - long overdrive for desert highways
	]
	shift_up_rpm = 4400
	shift_down_rpm = 2000

	# DISTINCT HANDLING PROFILE — Desert heavyweight with luxury damping
	handling_type = "desert_cruiser"

	# APPLY STATS + HANDLING
	apply_stats()

	print("Child READY loaded:", def_car_name)
