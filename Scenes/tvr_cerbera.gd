extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kestrel Touring"
var country := "UK"
var engine := "V8 4.2L"
var weight_kg := 1150
var zero_to_hundred_display := 4.30

func _ready():
	# GAMEPLAY STATS
	mass = 1150.0
	horsepower = 360
	max_rpm = 7200.0
	zero_to_hundred = 4.3
	top_speed_kmh = 292
	turn_speed = 3.25
	brake_strength = 12.6
	lateral_friction = 1.16
	transmission = "Rear wheel drive"

	# TVR-style 5-speed manual (short, violent gearing, explosive acceleration)
	gear_count = 5
	gear_ratios = [
		3.32,  # 1st - brutal lightweight launch
		2.14,  # 2nd - keeps the V8 screaming
		1.48,  # 3rd - Cerbera mid-range punch
		1.16,  # 4th - high-speed pull
		0.89   # 5th - long enough for 292 km/h
	]
	shift_up_rpm = 6900
	shift_down_rpm = 2600

	apply_stats()
	print("Child READY loaded:", def_car_name)
