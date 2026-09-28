extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Schroder D-20"
var country := "Germany"
var engine := "L4 2.0L Turbo Diesel"
var weight_kg := 1450
var zero_to_hundred_display := 6.90   # GTI-level acceleration

func _ready():
	# GAMEPLAY STATS
	mass = 1450.0
	horsepower = 190                 # Diesel tuned to match GTI acceleration
	max_rpm = 4800.0                 # Diesel redline
	idle_rpm = 800.0
	zero_to_hundred = 7.1
	top_speed_kmh = 238              # You requested this — GTI-level top speed
	turn_speed = 2.70                # More playful, GTI-like rotation
	brake_strength = 11.6            # Hot hatch brake feel
	lateral_friction = 1.14          # Grippy but not twitchy — diesel weight up front
	transmission = "Front wheel drive"
	is_diesel = true                 # Enables diesel torque behavior

	# HOT-HATCH DIESEL HANDLING
	# Strong low-end torque, lively mid-range, playful RWD balance

	gear_count = 6
	gear_ratios = [
		4.10,  # 1st - punchy diesel launch
		2.30,  # 2nd - strong mid-range pull
		1.55,  # 3rd - hot-hatch acceleration
		1.18,  # 4th
		1.00,  # 5th - direct
		0.84   # 6th - long overdrive
	]

	shift_up_rpm = 4400             # Diesels shift early
	shift_down_rpm = 2000

	apply_stats()
	print("Child READY loaded:", def_car_name)
