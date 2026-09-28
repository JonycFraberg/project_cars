extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kuro Vault"
var country := "Japan"
var engine := "V8 4.3L"
var weight_kg := 1760
var zero_to_hundred_display := 6.30

func _ready():
	# GAMEPLAY STATS
	mass = 1760.0
	horsepower = 290
	max_rpm = 5800.0
	zero_to_hundred = 6.4
	top_speed_kmh = 257
	turn_speed = 2.6
	brake_strength = 11.5
	lateral_friction = 1.02
	transmission = "Rear wheel drive"

	# LS430-style handling (smooth, soft, premium)
	

	# Toyota/Lexus V8 gearing (long, smooth, early shifts)
	gear_count = 5
	gear_ratios = [
		3.36,  # 1st - strong but smooth launch
		2.04,  # 2nd
		1.40,  # 3rd
		1.00,  # 4th
		0.75   # 5th - overdrive
	]
	shift_up_rpm = 5200
	shift_down_rpm = 2000

	apply_stats()
	print("Child READY loaded:", def_car_name)
