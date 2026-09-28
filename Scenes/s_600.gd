extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kronstadt Fortress"
var country := "Germany"
var engine := "V12 6.0L"
var weight_kg := 2150
var zero_to_hundred_display := 6.60

func _ready():
	# GAMEPLAY STATS — Heavy, overengineered German flagship sedan
	mass = 2150.0
	horsepower = 395
	max_rpm = 5800.0               # Smooth, low‑revving V12 tuned for effortless torque
	zero_to_hundred = 6.6
	top_speed_kmh =268
	turn_speed = 2.20              # Slow, deliberate steering; massive chassis weight
	brake_strength = 10.4          # Strong brakes, but fighting 2.1 tons of mass
	lateral_friction = 0.96        # Stable, planted grip; not sporty, but confident
	transmission = "Rear wheel drive"

	# Kronstadt 5-Speed Executive Gearbox
	# Tuned for smooth acceleration, highway authority, and presidential cruising
	gear_count = 5
	gear_ratios = [
		3.10,  # 1st - heavy launch, torque-rich but not aggressive
		1.98,  # 2nd - keeps the V12 in its torque plateau
		1.36,  # 3rd - smooth mid-range pull
		1.00,  # 4th - classic German autobahn gear
		0.78   # 5th - long overdrive for 250 km/h cruising
	]
	shift_up_rpm = 5600
	shift_down_rpm = 2400


	apply_stats()
	print("Child READY loaded:", def_car_name)
