extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Schroder Atrocity"
var country := "UAE"
var engine := "V10 5.2L"
var weight_kg := 1890
var zero_to_hundred_display := 4.50

func _ready():
	# GAMEPLAY STATS — UAE-built high-revving track machine
	mass = 1590.0
	horsepower = 440
	max_rpm = 8250.0               # Screaming V10 tuned for track dominance
	zero_to_hundred = 4.5
	top_speed_kmh = 307
	turn_speed = 3.20              # Sharper than any sedan; precision-focused steering
	brake_strength = 14.5          # Strong brakes for repeated high-speed stops
	lateral_friction = 1.14        # High grip RWD setup for track stability
	transmission = "Four wheel drive"

	# Mir Cars 7-Speed Track Gearbox
	# Short mid gears for acceleration, long 7th for top speed
	gear_count = 7
	gear_ratios = [
		4.05,  # 1st - explosive launch, traction-limited
		2.65,  # 2nd - early V10 scream
		1.92,  # 3rd - main acceleration gear
		1.46,  # 4th - high-speed pull begins
		1.18,  # 5th - mid-high speed
		0.96,  # 6th - long gear for 240–290 km/h
		0.80   # 7th - overdrive for 307 km/h
	]

	# SHIFT LOGIC — high-rev V10 aggression
	shift_up_rpm = 8000
	shift_down_rpm = 3000

	# DISTINCT HANDLING PROFILE — razor-sharp track coupe
	handling_type = "track_precision"

	apply_stats()
	print("Child READY loaded:", def_car_name)
