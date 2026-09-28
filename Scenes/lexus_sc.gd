extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kuro Serenity"
var country := "Japan"
var engine := "V8 4.0L"
var weight_kg := 1640
var zero_to_hundred_display := 6.40   # Smooth V8 launch

func _ready():
	# GAMEPLAY STATS
	mass = 1640.0
	horsepower = 260                  # 1UZ-FE output (Urban Racers spec)
	max_rpm = 6200.0                  # Smooth Lexus V8 rev band
	idle_rpm = 700.0
	zero_to_hundred = 6.4
	top_speed_kmh = 250               # Gentle GT top speed
	transmission = "Rear wheel drive"

	# HANDLING — Calm GT, but not soggy
	turn_speed = 2.45                 # Softer than XKR, heavier rotation
	brake_strength = 11.4             # Luxury brakes, slightly soft bite
	lateral_friction = 1.12           # Planted, stable, predictable
	handling_type = "luxury_gt"       # Smooth steering, gentle rotation

	# Lexus A341E 4-speed auto (Urban Racers sport-tuned)
	gear_count = 4
	gear_ratios = [
		2.80,  # 1st - smooth V8 launch
		1.53,  # 2nd - strong mid-range pull
		1.00,  # 3rd - direct
		0.70   # 4th - long GT overdrive
	]

	shift_up_rpm = 6000               # Smooth early shifts
	shift_down_rpm = 2500             # Calm downshifts

	apply_stats()
	print("Child READY loaded:", def_car_name)
