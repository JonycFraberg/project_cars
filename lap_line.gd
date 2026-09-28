extends Area3D

func _on_body_entered(body: Node) -> void:
	# Identify the car that triggered the LapLine
	var car: Node = body

	# Climb up until we find the CarController
	while car != null and not (car is CarController):
		car = car.get_parent()

	# If no valid car found, ignore
	if car == null:
		return

	# Register lap ONLY for Normal Race
	if Modes.mode.to_lower() == "normal race":
		NormalRaceManager.register_lap(car)

	# Register lap ONLY for Duel
	elif Modes.mode == "Duel":
		DuelManager.register_lap(car)
