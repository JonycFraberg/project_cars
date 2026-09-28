extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Eisenach Prince"
var country := "Germany"
var engine := "V8 4.4L"
var weight_kg := 1725
var zero_to_hundred_display := 4.60

func _ready():
	# GAMEPLAY STATS — heavy, overhyped executive brute
	mass = 1725.0
	horsepower =282
	max_rpm = 7000.0                 # High‑rev V8 but not torque‑friendly
	zero_to_hundred =5.2
	top_speed_kmh = 253
	turn_speed = 2.35                # Horrendous rotation; heavy understeer by design
	brake_strength = 12.8            # Good brakes but not enough for the weight
	lateral_friction = 1.06          # Executive sedan grip; not a track car
	transmission = "Rear wheel drive"

	# 6‑Speed Executive Gearbox — long gears, lazy mid‑range
	gear_count = 6
	gear_ratios = [
		4.00,  # 1st - strong launch but traction suffers
		2.40,  # 2nd - heavy mid‑range, slow rotation
		1.67,  # 3rd - main acceleration gear
		1.23,  # 4th - highway pull begins
		1.00,  # 5th - direct drive
		0.83   # 6th - long overdrive for 250 km/h
	]

	# SHIFT LOGIC — rev-dependent V8, not torque-friendly
	shift_up_rpm = 6800
	shift_down_rpm = 3000

	# DISTINCT HANDLING PROFILE — executive weight, hype-tax penalty
	handling_type = "executive_oversteer"

	apply_stats()
	print("Child READY loaded:", def_car_name)
