extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Eisenach Black Panda"
var country := "Germany"
var engine := "V6 3.0L Diesel"
var weight_kg := 1600
var zero_to_hundred_display := 6.10   # Diesel punch, strong mid-range launch

func _ready():
	# GAMEPLAY STATS
	mass = 1600.0
	horsepower = 231                 # M57D30 output (330d)
	max_rpm = 5000.0                 # Diesel redline; strong torque band
	zero_to_hundred = 6.1
	top_speed_kmh = 253            # Realistic tuned 330d top speed
	turn_speed = 2.55                # Heavier than 125i; stable diesel rotation
	brake_strength = 11.2            # Strong brakes; diesel weight accounted for
	lateral_friction = 1.15          # Confident grip; planted BMW chassis
	transmission = "Rear wheel drive"

	# 330d-style handling (torquey, stable, grown-man diesel balance)

	# BMW 6-Speed Automatic Gearing (diesel ratios)
	gear_count = 6
	gear_ratios = [
		4.17,  # 1st - Diesel shove, strong low-end torque
		2.34,  # 2nd - Big mid-range punch
		1.52,  # 3rd - Main acceleration gear
		1.14,  # 4th
		0.87,  # 5th - Efficient pull
		0.69   # 6th - Long highway gear
	]

	shift_up_rpm = 4600             # Diesel power peak
	shift_down_rpm = 2000           # Keep torque alive
	is_diesel=true
	
	apply_stats()
	print("Child READY loaded:", def_car_name)
