extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Schroder Atrix Q32"
var country := "Germany"
var engine := "V6 3.2L"
var weight_kg := 1470
var zero_to_hundred_display := 6.40

func _ready():
	# GAMEPLAY STATS
	mass = 1470.0
	horsepower = 247
	max_rpm = 6500.0
	zero_to_hundred = 6.6
	top_speed_kmh = 250
	turn_speed = 2.7
	brake_strength = 20.0
	lateral_friction = 1.15
	transmission = "Four wheel drive"

	

	apply_stats()
	print("Child READY loaded:", def_car_name)
