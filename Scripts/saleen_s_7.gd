extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Mir Cars Raptor"
var country := "UAE"
var engine := "V8 7.0L"
var weight_kg := 1378
var zero_to_hundred_display := 3.80

func _ready():
	# GAMEPLAY STATS — UAE-built analog supercar, lightweight & brutal
	mass = 1378.0
	horsepower = 532
	max_rpm = 6800.0               # High-revving big V8 with explosive mid-range torque
	zero_to_hundred = 3.8
	top_speed_kmh = 327
	turn_speed = 3.15              # Razor-sharp front end, lightweight rear behavior
	brake_strength = 14.4          # Strong brakes for repeated high-speed runs
	lateral_friction = 1.18        # High grip RWD setup for aggressive cornering
	transmission = "Rear wheel drive"

	# Mir Cars 6-Speed Supercar Gearbox
	# Short lower gears for acceleration, long 6th for top speed
	gear_count = 6
	gear_ratios = [
		2.95,  # 1st - violent V8 launch, traction-limited
		2.05,  # 2nd - strong pull into mid-range
		1.42,  # 3rd - main acceleration gear
		1.13,  # 4th - high-speed sweepers
		0.96,  # 5th - mid-high speed
		0.78   # 6th - long overdrive for 327 km/h
	]

	# SHIFT LOGIC — analog supercar aggression
	shift_up_rpm = 6500
	shift_down_rpm = 3000

	# DISTINCT HANDLING PROFILE — lightweight, sharp, desert-born supercar
	handling_type = "analog_supercar"

	apply_stats()
	print("Child READY loaded:", def_car_name)
