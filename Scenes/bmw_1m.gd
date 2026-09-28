extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Eisenach Goblin"
var country := "Germany"
var engine := "L6 3.0L Twin‑Turbo"
var weight_kg := 1500
var zero_to_hundred_display := 4.60   # compact GT hooligan launch

func _ready():
	# GAMEPLAY STATS
	mass = 1500.0
	horsepower = 340
	max_rpm = 7000.0
	zero_to_hundred = 4.6
	top_speed_kmh = 258                 # angry mid‑range, limited top speed
	turn_speed = 3.05                   # short‑wheelbase rotation, lively front bite
	brake_strength = 14.2               # strong brakes for a compact GT
	lateral_friction = 1.14             # grippy but still playful; turbo oversteer possible
	transmission = "Rear wheel drive"

	# 1M Coupé handling (explosive, twitchy, compact GT aggression)

	# TRUE 6‑speed manual (GS6‑53DZ inspired)
	gear_count = 6
	gear_ratios = [
		4.10,  # 1st - brutal turbo punch off the line
		2.32,  # 2nd - strong pull to ~90 km/h
		1.58,  # 3rd - main acceleration gear
		1.19,  # 4th - keeps boost alive
		1.00,  # 5th - direct drive
		0.84   # 6th - compact GT overdrive, capped at 253 km/h
	]

	shift_up_rpm = 6600
	shift_down_rpm = 2800

	apply_stats()
	print("Child READY loaded:", def_car_name)
