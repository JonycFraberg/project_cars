extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kronstadt Essence"
var country := "Germany"
var engine := "V8 5.4L"
var weight_kg := 1540
var zero_to_hundred_display := 5.10   # AMG punch

func _ready():
	# GAMEPLAY STATS — Mature German GT with AMG shove
	mass = 1640.0
	horsepower = 360                   # CLK 55 AMG real-world output
	max_rpm = 6200.0                    # Broad, torquey AMG rev band
	idle_rpm = 700.0
	zero_to_hundred = 5.2
	top_speed_kmh = 253     # Gentle GT top speed with muscle
	transmission = "Rear wheel drive"

	# HANDLING — Calm GT with hidden aggression
	turn_speed = 2.52                   # Slightly heavier than SC400, AMG weight
	brake_strength = 12.0               # Stronger clamp than Lexus, AMG brakes
	lateral_friction = 1.15             # Planted, stable, confident
	handling_type = "luxury_gt"         # Smooth steering, composed rotation

	# AMG 5G-Tronic 5-speed auto (Urban Racers sport-tuned)
	gear_count = 5
	gear_ratios = [
		3.95,  # 1st - hard V8 launch
		2.41,  # 2nd - torque wave
		1.53,  # 3rd - strong mid-range
		1.00,  # 4th - direct pull
		0.83   # 5th - GT overdrive
	]

	shift_up_rpm = 6000                 # Early AMG-style shifts
	shift_down_rpm = 2600               # Smooth GT downshifts

	apply_stats()
	print("Child READY loaded:", def_car_name)
