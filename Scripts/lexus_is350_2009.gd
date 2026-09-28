extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kuro Zephyr V6"
var country := "Japan"
var engine := "V6 3.5L"
var weight_kg := 1600
var zero_to_hundred_display := 5.60  # RWD launch makes it slightly quicker than the ES350

func _ready():
	# GAMEPLAY STATS
	mass = 1600.0
	horsepower = 306            # Upgraded from 272 (IS350's direct-injection V6 has more punch)
	max_rpm = 6600.0            # High-revving 2GR-FSE engine
	zero_to_hundred = 5.6
	top_speed_kmh = 250         # Stays at the 242 ceiling, but gets there much faster
	turn_speed = 2.65           # Noticeably sharper than the ES350; RWD lets the front wheels focus purely on steering
	brake_strength = 12.5       # Sport brakes offer stronger stopping power
	lateral_friction = 1.10     # High cornering grip, but RWD means the rear will break loose under heavy throttle
	transmission = "Rear wheel drive" # Changed from Front wheel drive

	# IS350-style handling (Sharp, agile, athletic, prone to power-slides if pushed too hard)
	

	# Toyota/Lexus 2GR-FSE 6-Speed Sport Gearing (Tighter ratios to maximize the higher 306 hp power band)
	gear_count = 6
	gear_ratios = [
		3.62,  # 1st - Aggressive RWD launch torque
		2.19,  # 2nd - Snappy acceleration out of tight corners
		1.54,  # 3rd
		1.21,  # 4th
		1.00,  # 5th
		0.77   # 6th - Overdrive highway cruise
	]
	shift_up_rpm = 6400        # Sports V6 pulls harder up into the rev range
	shift_down_rpm = 2800

	apply_stats()
	print("Child READY loaded:", def_car_name)
