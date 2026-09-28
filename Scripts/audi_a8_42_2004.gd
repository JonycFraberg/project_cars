extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Mir Cars Transporter"
var country := "UAE"
var engine := "V8 5.0L"
var weight_kg := 1780
var zero_to_hundred_display := 6.20

func _ready():
	# GAMEPLAY STATS — UAE performance sedan with AWD traction
	mass = 1780.0
	horsepower = 343
	max_rpm = 6500.0               # High-revving 5.0L tuned for strong mid-range acceleration
	zero_to_hundred = 5.9
	top_speed_kmh = 250
	turn_speed = 2.55              # Balanced steering; heavier than sport sedans, lighter than SUVs
	brake_strength = 11.2          # Strong brakes for a 1.7-ton AWD chassis
	lateral_friction = 1.08        # Confident AWD grip on pavement and desert roads
	transmission = "Four wheel drive"

	# Mir Cars 6-Speed Performance AWD Gearbox
	# Tuned for quick launches, highway speed, and desert stability
	gear_count = 6
	gear_ratios = [
		3.42,  # 1st - strong AWD launch
		2.10,  # 2nd - keeps Transporter in its torque band
		1.46,  # 3rd
		1.13,  # 4th
		0.92,  # 5th
		0.78   # 6th - long overdrive for 257 km/h
	]
	shift_up_rpm = 6200
	shift_down_rpm = 2600

	# DISTINCT HANDLING PROFILE — Heavy, stable, UAE performance sedan
	handling_type = "performance_sedan"

	apply_stats()
	print("Child READY loaded:", def_car_name)
