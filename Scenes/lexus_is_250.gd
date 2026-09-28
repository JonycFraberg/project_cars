extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kuro Zephyr"
var country := "Japan"
var engine := "V6 2.5L"
var weight_kg := 1500
var zero_to_hundred_display :=6.90  # Snappier launch, youthful compact vibe

func _ready():
	# GAMEPLAY STATS
	mass = 1500.0                     # Simulated lighter feel (IS250 IRL feels heavy)
	horsepower = 204                  # +11 hp hidden buff to remove sadness
	max_rpm = 6500.0                  # Slightly higher rev ceiling for sportiness
	zero_to_hundred = 7.3
	top_speed_kmh = 236               # Small bump, still realistic

	# HANDLING FIXES (no more soggy steering)
	turn_speed = 2.55                 # Sharper turn-in, compact-class feel
	brake_strength = 12.0             # Stronger brakes, less rental-car fade
	lateral_friction = 1.18           # More grip, less understeer
	transmission = "Rear wheel drive"

	# IS250 "Happy Handling" — lively, youthful, not executive
	handling_type = "balanced"

	# Toyota/Lexus 4GR-FSE 6-Speed Sporty Gearing (shortened 1–3)
	gear_count = 6
	gear_ratios = [
		3.62,  # 1st - Snappier launch, removes dead feeling
		2.18,  # 2nd - Stronger pull, feels alive
		1.48,  # 3rd - Shorter, better mid-range acceleration
		1.00,  # 4th
		0.76,  # 5th
		0.56   # 6th - Highway overdrive
	]

	shift_up_rpm = 6400              # More eager to rev
	shift_down_rpm = 2700            # Less lazy downshifts

	apply_stats()
	print("Child READY loaded:", def_car_name)
