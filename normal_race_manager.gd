extends Node


var player_car_path: String = ""
var ai_car_paths: Array = []        # 7 AI car scene paths


var player_spawn: Vector3 = Vector3.ZERO
var ai_spawns: Array = []


var player_car: CarController = null
var ai_cars: Array[CarController] = []


var race_active: bool = false
var total_laps: int = 3


var hud: Node = null
var main_scene: Node = null


# lap + waypoint tracking
var car_laps := {}
var last_wp := {}
var lap_cooldown := {}










func spawn_race(scene: Node) -> void:
	race_active = false
	CarController.used_ai_names = CarController.ai_names.duplicate()


	# Remove old cars
	if player_car and player_car.is_inside_tree():
		player_car.queue_free()


	for ai in ai_cars:
		if ai and ai.is_inside_tree():
			ai.queue_free()


	ai_cars.clear()
	
	# Career lap rules
	if Cars.selected_class in ["suv", "colossus"]:
		total_laps = 2
	else:
		total_laps = 3


	await get_tree().process_frame


	var root := scene.get_node(TrackName.track_name)


	player_spawn = root.get_node("SpawnPoint").global_transform.origin


	ai_spawns.clear()
	for i in range(7):
		ai_spawns.append(root.get_node("AISpawnPoint" + str(i + 1)).global_transform.origin)


	RaceResults.clear()
	main_scene = scene
	hud = scene.get_node("HUD")




	# PLAYER
	var player_scene := load(player_car_path)
	player_car = player_scene.instantiate() as CarController
	player_car.is_ai = false
	player_car.global_transform = root.get_node("SpawnPoint").global_transform
	player_car.controls_enabled = false
	player_car.driver_name = "Player"
	player_car.car_name = Cars.selected_car_name
	scene.add_child(player_car)


	_apply_player_color(player_car)


	await get_tree().process_frame
	await get_tree().process_frame


	if player_car.has_node("Camera3D"):
		player_car.get_node("Camera3D").current = true


	# AI CARS
	ai_cars.clear()
	
	ai_car_paths = Cars.get_ai_paths_for_class(null)


	for i in range(ai_spawns.size()):
		var path: String = ai_car_paths[i % ai_car_paths.size()]
		var ai_scene := load(path)
		var ai := ai_scene.instantiate() as CarController
		scene.add_child(ai)


		if ai.has_node("Camera3D"):
			ai.get_node("Camera3D").current = false


		var spawn_node := root.get_node("AISpawnPoint" + str(i + 1))
		ai.global_transform = spawn_node.global_transform
		ai.is_ai = true
		ai.controls_enabled = false


		ai.driver_name = ai.ai_names[randi() % ai.ai_names.size()]
		var car_name := ""
		for name in Cars.car_scene_paths.keys():
			if Cars.car_scene_paths[name] == path:
				car_name = name
				break


		ai.car_name = car_name


		_apply_random_ai_color(ai)


		ai_cars.append(ai)


	await get_tree().process_frame
	await get_tree().process_frame


	# WAYPOINTS
	var wp_root := scene.find_child("Waypoints", true, false)
	player_car.set_waypoints(wp_root)


	for ai in ai_cars:
		ai.set_waypoints(wp_root)


	# INIT lap dictionaries
	init_lap_system()




	hud.update_lap(1, total_laps)
	hud.update_position(ai_cars.size() + 1, ai_cars.size() + 1)



	var all_cars = get_all_race_cars()
	scene.get_node("Start").start_countdown(all_cars)


func on_countdown_finished():
	race_active = true

	MusicManager.play_race_music()

	player_car.controls_enabled = true

	for ai in ai_cars:
		ai.controls_enabled = true






func init_lap_system():
	car_laps.clear()
	last_wp.clear()


	car_laps[player_car] = 0
	last_wp[player_car] = 0


	for ai in ai_cars:
		car_laps[ai] = 0
		last_wp[ai] = 0






func register_lap(body: Node) -> void:
	if not race_active:
		return


	var car := body
	while car != null and not (car is CarController):
		car = car.get_parent()


	if car == null:
		return


	if not car_laps.has(car):
		return


	if lap_cooldown.get(car, false):
		return


	# PLAYER LAP COUNTS HERE
	car_laps[car] += 1
	# Freeze finish time the moment the car finishes
	if car_laps[car] >= total_laps and car.finished_time < 0:
		car.finished_time = car.total_race_time
	# Freeze AI movement immediately when they finish
	if car != player_car and car_laps[car] >= total_laps:
		car.controls_enabled = false
		car.hard_frozen = true




	lap_cooldown[car] = true
	_start_lap_cooldown(car)


	if car == player_car:
		_check_finish()






func get_all_race_cars() -> Array:
	var arr = []
	if player_car:
		arr.append(player_car)
	for ai in ai_cars:
		arr.append(ai)
	return arr






func _start_lap_cooldown(car):
	await get_tree().create_timer(0.8).timeout
	lap_cooldown[car] = false




func _check_finish() -> void:
	if not race_active:
		return


	# Only end race when PLAYER finishes
	if car_laps[player_car] >= total_laps:
		var pos := _calculate_position()
		var player_won := false


		# Player must be FIRST to win
		if pos <=3:
			player_won = true
		else:
			player_won = false


		if player_won:
			_end_race("Player")
		else:
			_end_race("AI")


func _get_wp_index(car: CarController) -> int:
	var waypoints := car.waypoints
	if waypoints.is_empty():
		return 0


	var best_index := 0
	var best_dist := INF


	for i in range(waypoints.size()):
		var wp := waypoints[i]
		var d := car.global_position.distance_to(wp.global_position)
		if d < best_dist:
			best_dist = d
			best_index = i


	return best_index


func _distance_to_next_wp_from_index(car: CarController, wp_index: int) -> float:
	var waypoints := car.waypoints
	if waypoints.is_empty():
		return 0.0


	var next_wp := wp_index + 1
	if next_wp >= waypoints.size():
		next_wp = 0


	var wp := waypoints[next_wp]
	return car.global_position.distance_to(wp.global_position)


func _end_race(winner: String) -> void:
	race_active = false


	# Freeze cars
	player_car.controls_enabled = false
	for ai in ai_cars:
		ai.controls_enabled = false


	var participants: Array = []
	var total_wp: int = player_car.waypoints.size()
	# --- FORCE-FINISH ANY AI THAT REACHED FINAL LAP PROGRESS ---
	var final_progress := total_laps * total_wp


	for ai in ai_cars:
		var laps :int= car_laps.get(ai, 0)
		var wp_index := _get_wp_index(ai)
		var progress :int= laps * total_wp + wp_index


		if progress >= final_progress and ai.finished_time < 0:
			ai.finished_time = ai.total_race_time
			ai.controls_enabled = false
			ai.hard_frozen = true


	# --- PLAYER (PROXIMITY INDEX) ---
	var p_laps: int = car_laps.get(player_car, 0)
	var p_wp_index: int = _get_wp_index(player_car)
	var p_progress: int = (p_laps * total_wp) + p_wp_index
	var p_dist: float = _distance_to_next_wp_from_index(player_car, p_wp_index)
			
			
	var p_time := player_car.total_race_time
	if player_car.finished_time >= 0:
			p_time = player_car.finished_time


	participants.append({
		"car_obj": player_car,
		"name": player_car.driver_name,
		"car_name": player_car.car_name,
		"progress": p_progress,
		"dist": p_dist,
		"real_time": p_time,
		"finished": player_car.finished_time >= 0


	})


	# --- AI (PROXIMITY INDEX) ---
	for ai: CarController in ai_cars:
		var laps: int = car_laps.get(ai, 0)
		var ai_wp_index: int = _get_wp_index(ai)
		var ai_progress: int = (laps * total_wp) + ai_wp_index
		var ai_dist: float = _distance_to_next_wp_from_index(ai, ai_wp_index)
		var ai_time := ai.total_race_time
		if ai.finished_time >= 0:
				ai_time = ai.finished_time


		participants.append({
			"car_obj": ai,
			"name": ai.driver_name,
			"car_name": ai.car_name,
			"progress": ai_progress,
			"dist": ai_dist,
			"real_time": ai_time,
			"finished": ai.finished_time >= 0
		})


	# --- SORT BY REAL RACE POSITION (PROXIMITY) ---
	participants.sort_custom(func(a, b):
	# 1. Finished cars always come before unfinished cars
		if a["finished"] != b["finished"]:
			return a["finished"] and not b["finished"]


		# 2. If both finished, sort by real_time (lower = better)
		if a["finished"] and b["finished"]:
			return a["real_time"] < b["real_time"]


		# 3. If neither finished, fall back to progress + dist
		if a["progress"] != b["progress"]:
			return a["progress"] > b["progress"]


		return a["dist"] < b["dist"]
)




	# --- GENERATE FINAL TIMES ---
	RaceResults.clear()


	var winner_time: int = participants[0]["real_time"]


	for i: int in participants.size():
		var p: Dictionary = participants[i]
		var final_time: int


		if i == 0:
			# Winner always keeps real time
			final_time = p["real_time"]
		else:
			if p["finished"]:
				# Finished → keep real time
				final_time = p["real_time"]
			else:
				# Not finished → estimate time
				final_time = _estimate_ai_finish_time_for(p["car_obj"])
				
		RaceResults.add_result(
			p["name"],
			p["car_name"],
			final_time,
			p["progress"],
			p["dist"]
		)


	# --- SHOW FINISH SCREEN ---
	main_scene.show_finish(winner == "Player")
	hud.visible = false
	MusicManager.stop_music()






func update_race() -> void:
	if not race_active or not is_instance_valid(player_car):
		return


	var sorted := _sorted_cars()
	var player_pos := _calculate_position()


	hud.update_stopwatch(player_car.total_race_time)
	hud.update_lap(car_laps[player_car] + 1, total_laps)
	hud.update_position(player_pos, ai_cars.size() + 1)


	# Freeze any AI that finished
	for ai in ai_cars:
		if car_laps[ai] >= total_laps and ai.finished_time < 0:
			ai.finished_time = ai.total_race_time
			ai.controls_enabled = false
			ai.hard_frozen = true


	# ⭐ PLAYER FINISH LOGIC ⭐
	if car_laps[player_car] >= total_laps:
		var player_won := false
		if player_pos <= 3:
			player_won = true


		main_scene.show_results(player_won)


		var winner_string := ""
		if player_pos <= 3:
			winner_string = "Player"
		else:
			winner_string = "AI"


		_end_race(winner_string)


			




func _distance_to_next_wp(car: CarController) -> float:
	if car.waypoints.is_empty():
		return 0.0


	var next_wp := car.current_wp + 1
	if next_wp >= car.waypoints.size():
		next_wp = 0


	var wp := car.waypoints[next_wp] as Node3D
	return car.global_position.distance_to(wp.global_position)




func _calculate_position() -> int:
	var sorted := _sorted_cars()


	# If sorting failed → assume LAST place
	if sorted.is_empty():
		return ai_cars.size() + 1


	for i in range(sorted.size()):
		if sorted[i] == player_car:
			return i + 1


	# If somehow not found → last place
	return ai_cars.size() + 1


func _sorted_cars() -> Array:
	var result := []


	# If player has no waypoints, sorting is impossible
	if not is_instance_valid(player_car) or player_car.waypoints.is_empty():
		return [player_car] + ai_cars


	if player_car.waypoints.is_empty():
		return result


	var total_wp := player_car.waypoints.size()
	var cars := []


	for car in [player_car] + ai_cars:
		# Skip cars with missing waypoint lists
		if car.waypoints.is_empty():
			continue


		var lap :int= car_laps.get(car, 0)
		var wp_index := _get_wp_index(car)
		var progress := lap * total_wp + wp_index
		var dist := _distance_to_next_wp_from_index(car, wp_index)


		cars.append({
			"car": car,
			"progress": progress,
			"dist": dist
		})


	# If no cars were added → return empty
	if cars.is_empty():
		return result


	# Sort by progress first, then distance
	cars.sort_custom(func(a, b):
		if a["progress"] != b["progress"]:
			return a["progress"] > b["progress"]
		return a["dist"] < b["dist"]
	)


	for c in cars:
		result.append(c["car"])


	return result




func _apply_player_color(car: CarController) -> void:
	var color: Color = Cars.selected_color
	if car.has_node("ModelRoot/Body"):
		var body := car.get_node("ModelRoot/Body")
		for child in body.get_children():
			if child is MeshInstance3D:
				var mat: Material = child.get_active_material(0)
				if mat is BaseMaterial3D:
					mat.albedo_color = color




func _apply_random_ai_color(car: CarController) -> void:
	var car_name: String = car.car_name


	if not Cars.car_colors.has(car_name):
		return


	var palette: Array = Cars.car_colors[car_name]
	if palette.is_empty():
		return


	var chosen_color: Color = palette[int(randf() * palette.size())]


	if car.has_node("ModelRoot/Body"):
		var body: Node = car.get_node("ModelRoot/Body")


		for child: Node in body.get_children():
			if child is MeshInstance3D:
				var mesh_instance: MeshInstance3D = child


				var mat: StandardMaterial3D = StandardMaterial3D.new()
				mat.albedo_color = chosen_color


				# ⭐ THIS IS THE FIX ⭐
				mesh_instance.material_override = mat


func _estimate_ai_finish_time_for(ai: CarController) -> int:
	var lapline: Node3D = main_scene.find_child("LapLine", true, false)
	if lapline == null:
		return ai.total_race_time

	var wp: Array = ai.waypoints
	if wp.is_empty():
		return ai.total_race_time

	var lap_dist: float = 0.0
	for i in range(wp.size()):
		var a: Vector3 = wp[i].global_position
		var b: Vector3 = wp[(i + 1) % wp.size()].global_position
		lap_dist += a.distance_to(b)

	var laps_done: int = car_laps.get(ai, 0)
	var remaining_dist: float = ai.distance_to_finish_line(lapline)

	# ⭐ FIX: If the car is very close to the finish line (e.g. within 15% of a lap), 
	# and it's on the last active lap, don't add a phantom full lap.
	var laps_left: int = total_laps - laps_done
	if remaining_dist < (lap_dist * 0.15) and laps_left > 0:
		laps_left -= 1  # It's basically finished, don't add an extra lap

	remaining_dist += lap_dist * float(max(laps_left, 0))

	# Average speed calculation
	var race_time_sec: float = max(float(ai.total_race_time) / 1000.0, 0.1)
	var avg_speed: float = ai.distance_travelled / race_time_sec  

	if avg_speed <= 1.0:
		avg_speed = clamp(ai.current_speed * 0.8, 10.0, 120.0)

	var remaining_time_ms: int = int((remaining_dist / avg_speed) * 1000)
	remaining_time_ms = int(remaining_time_ms * 1.03)

	return ai.total_race_time + remaining_time_ms

		




func force_player_camera():
	if player_car and player_car.has_node("Camera3D"):
		player_car.get_node("Camera3D").current = true
