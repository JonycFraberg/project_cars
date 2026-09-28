extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Zenith Horizon"
var country := "Japan"
var engine := "V6 3.5L"
var weight_kg := 1460
var zero_to_hundred_display := 5.90

func _ready():
	# GAMEPLAY STATS
	mass = 1460.0
	horsepower = 287
	max_rpm = 6500.0
	zero_to_hundred = 6.4
	top_speed_kmh = 250
	turn_speed = 2.9
	brake_strength = 20.0
	lateral_friction = 1.12
	transmission = "Rear wheel drive"

	

	apply_stats()
	
	print("Child READY loaded:", def_car_name)
