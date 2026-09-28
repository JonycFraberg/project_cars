extends CanvasLayer

var target_car: CarController

func _process(delta: float) -> void:
	$Control/Speed.text = "%d %s" % [
		int(round(Global.speed)),
		Global.speed_unit
	]

	if Global.gear == -1:
		$Control/Gear.text = "R"
	else:
		$Control/Gear.text = "G" + str(Global.gear)
