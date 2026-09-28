extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Brutus Venom"
var country := "USA"
var engine := "V10 8.0L"
var weight_kg := 1560
var zero_to_hundred_display := 4.10

func _ready():
	# GAMEPLAY STATS
	mass = 1560.0
	horsepower = 415
	max_rpm = 5600.0
	zero_to_hundred = 4.1
	top_speed_kmh = 300
	turn_speed = 2.85
	brake_strength = 11.5
	lateral_friction = 1.02
	transmission = "Rear wheel drive"

	# Viper RT/10 handling (raw, heavy steering, torque-heavy)
	
	# Dodge 6-speed manual (long gears, big torque)
	gear_count = 6
	gear_ratios = [
		2.66,  # 1st - brutal launch torque
		1.78,  # 2nd
		1.30,  # 3rd
		1.00,  # 4th
		0.74,  # 5th
		0.50   # 6th - long overdrive
	]
	shift_up_rpm = 5200
	shift_down_rpm = 2000

	apply_stats()
	print("Child READY loaded:", def_car_name)
