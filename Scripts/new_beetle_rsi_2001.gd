extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Straeda B32"
var country := "Germany"
var engine := "V6 3.2L"
var weight_kg := 1500
var zero_to_hundred_display := 6.70

func _ready():
	# GAMEPLAY STATS
	mass = 1500.0
	horsepower = 224
	max_rpm = 6500.0
	zero_to_hundred = 6.7
	top_speed_kmh = 236
	turn_speed = 2.5
	brake_strength = 20.0
	lateral_friction = 1.20
	transmission = "Four wheel drive"

	# DISTINCT HANDLING PROFILE
	
	# APPLY STATS + HANDLING
	apply_stats()
	

	print("Child READY loaded:", def_car_name)
