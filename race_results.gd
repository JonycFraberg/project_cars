extends Node

var player_name := "Player"
var results: Array = []

func clear() -> void:
	results.clear()

func add_result(name: String, car: String, time_ms: int, progress: int, dist: float) -> void:
	results.append({
		"name": name,
		"car": car,
		"time": time_ms,
		"progress": progress,
		"dist": dist
	})
