extends Node

var player_car_path: String = ""
var ai_car_path: String = ""

var player_spawn: Vector3 = Vector3.ZERO
var ai_spawn: Vector3 = Vector3.ZERO

var player_car: CarController = null
var ai_car: CarController = null

var duel_active: bool = false
var winner: String = ""

var player_laps: int = 0
var ai_laps: int = 0
var total_laps: int = 2

var lap_cooldown: bool = false
var hud: Node = null
var player_finished: bool = false
var ai_finished: bool = false


var player_crossed_start: bool = false
var ai_crossed_start: bool = false
var main_scene: Node = null



func _process(delta):
	if duel_active:
		update_duel()


func spawn_duel(main_scene: Node) -> void:
	RaceResults.clear()

	if GameMode.game_mode != "Club Cups":
		ai_car_path = _pick_unique_ai_car()

	CarController.used_ai_names = CarController.ai_names.duplicate()

	if player_car_path == "" or ai_car_path == "":
		push_error("DuelManager: Car paths not set!")
		return

	hud = main_scene.get_node("HUD")
	hud.update_lap(0, total_laps)
	hud.update_position(2, 2)

	# PLAYER
	var player_scene := load(player_car_path)
	player_car = player_scene.instantiate() as CarController
	player_car.global_position = player_spawn
	player_car.is_ai = false
	player_car.controls_enabled = false

	player_car.driver_name = "Player"
	player_car.car_name = Cars.selected_car_name

	main_scene.add_child(player_car)
	_apply_player_color(player_car)

	Cars.apply_auto_class_if_not_club()

	await get_tree().process_frame
	await get_tree().process_frame

	if player_car.has_node("Camera3D"):
		player_car.get_node("Camera3D").current = true

	# AI
	var ai_scene := load(ai_car_path)
	ai_car = ai_scene.instantiate() as CarController
	ai_car.global_position = ai_spawn
	ai_car.is_ai = true
	ai_car.controls_enabled = false

	main_scene.add_child(ai_car)
	_apply_random_ai_color(ai_car)

	ai_car.driver_name = ai_car.ai_names[randi() % ai_car.ai_names.size()]

	await get_tree().process_frame

	ai_car.car_name = Cars.selected_ai_car_name

	if ai_car.has_node("Camera3D"):
		ai_car.get_node("Camera3D").current = false

	# WAYPOINTS
	var wp_root := main_scene.find_child("Waypoints", true, false)
	player_car.set_waypoints(wp_root)
	ai_car.set_waypoints(wp_root)

	# RESET RACE STATE
	player_laps = 0
	ai_laps = 0
	player_crossed_start = false
	ai_crossed_start = false
	player_finished = false
	ai_finished = false
	winner = ""

	player_car.finished_time = -1
	ai_car.finished_time = -1

	duel_active = true

	hud.update_lap(1, total_laps)
	hud.update_position(2, 2)

	# START COUNTDOWN AFTER BOTH CARS EXIST
	var all_cars = get_all_race_cars()
	main_scene.get_node("Start").start_countdown(all_cars)

	print("DuelManager: Duel started.")


func _pick_unique_ai_car() -> String:
	var cls: String = Cars.selected_class
	var list: Array = Cars.class_lists.get(cls, [])

	var filtered: Array = []
	for name in list:
		if name != Cars.selected_car_name:
			filtered.append(name)

	if filtered.size() == 0:
		Cars.selected_ai_car_name = Cars.selected_car_name
		return Cars.selected_car

	var chosen_name: String = filtered[randi() % filtered.size()]
	Cars.selected_ai_car_name = chosen_name

	return Cars.car_scene_paths[chosen_name]


func get_all_race_cars() -> Array:
	var arr = []
	if player_car:
		arr.append(player_car)
	if ai_car:
		arr.append(ai_car)
	return arr

func _apply_player_color(car: CarController) -> void:
	var color: Color = Cars.selected_color
	if car.has_node("ModelRoot/Body"):
		var body := car.get_node("ModelRoot/Body")
		for child in body.get_children():
			if child is MeshInstance3D:
				var mat :Material= child.get_active_material(0)
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
		
func update_duel() -> void:
	if not duel_active  or not is_instance_valid(player_car): 
		return


	# ❌ REMOVE extra lap logic from waypoints
	# _update_laps_from_progress()

	if not player_finished:
			
		hud.update_stopwatch(player_car.total_race_time)
			
	hud.update_lap(player_laps + 1, total_laps)
	hud.update_position(_calculate_position(), 2)
	_check_finish()



func register_lap(body: Node) -> void:
	if not duel_active or lap_cooldown:
		return

	var car := body
	while car != null and not (car is CarController):
		car = car.get_parent()

	if car == null:
		return

	lap_cooldown = true
	_start_lap_cooldown()

	# PLAYER LAP
	if car == player_car:
		player_laps += 1

		if player_laps >= total_laps and player_car.finished_time < 0:
			player_car.finished_time = player_car.total_race_time
			_end_duel()   # Duel ends immediately (Option A)

	# AI LAP
	elif car == ai_car:
		ai_laps += 1

		if ai_laps >= total_laps and ai_car.finished_time < 0:
			ai_car.finished_time = ai_car.total_race_time
			_end_duel()   # Duel ends immediately (Option A)

func _start_lap_cooldown() -> void:
	await get_tree().create_timer(1.0).timeout
	lap_cooldown = false


func _check_finish() -> void:
	# Duel ends instantly when ANY car finishes
	if player_car.finished_time >= 0 or ai_car.finished_time >= 0:
		_end_duel()


func _end_duel() -> void:
	duel_active = false
	player_car.controls_enabled = false
	ai_car.controls_enabled = false

	var participants: Array = []
	var total_wp: int = player_car.waypoints.size()

	# --- PLAYER ---
	var p_progress: int = (player_laps * total_wp) + player_car.current_wp
	var p_dist: float = _distance_to_next_wp(player_car)

	var p_time: int = player_car.total_race_time
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

	# --- AI ---
	var ai_progress: int = (ai_laps * total_wp) + ai_car.current_wp
	var ai_dist: float = _distance_to_next_wp(ai_car)

	var ai_time: int = ai_car.total_race_time
	if ai_car.finished_time >= 0:
		ai_time = ai_car.finished_time

	participants.append({
		"car_obj": ai_car,
		"name": ai_car.driver_name,
		"car_name": ai_car.car_name,
		"progress": ai_progress,
		"dist": ai_dist,
		"real_time": ai_time,
		"finished": ai_car.finished_time >= 0
	})

	# --- FINAL SORT (same flawless logic as NormalRaceManager) ---
	participants.sort_custom(func(a, b):
		# Finished cars first
		if a["finished"] != b["finished"]:
			return a["finished"] and not b["finished"]

		# Both finished → sort by real_time only
		if a["finished"] and b["finished"]:
			return a["real_time"] < b["real_time"]

		# Neither finished → sort by progress
		if a["progress"] != b["progress"]:
			return a["progress"] > b["progress"]

		# Tie-breaker: distance
		return a["dist"] < b["dist"]
	)

	# --- FINAL TIMES ---
	RaceResults.clear()

	for p in participants:
		RaceResults.add_result(
			p["name"],
			p["car_name"],
			p["real_time"],
			p["progress"],
			p["dist"]
		)

	# Winner = whoever sorted first
	var winner_car: CarController = participants[0]["car_obj"]
	main_scene.show_finish(winner_car == player_car)
	hud.visible = false
	MusicManager.stop_music()

func _calculate_position() -> int:
	# LAP FIRST
	if player_laps > ai_laps:
		return 1
	elif ai_laps > player_laps:
		return 2

	# WAYPOINT INDEX
	var p_wp := player_car.current_wp
	var a_wp := ai_car.current_wp

	if p_wp > a_wp:
		return 1
	elif a_wp > p_wp:
		return 2

	# DISTANCE TO SAME WP
	var wp := player_car.waypoints[p_wp]
	var p_dist := player_car.global_position.distance_to(wp.global_position)
	var a_dist := ai_car.global_position.distance_to(wp.global_position)

	return 1 if p_dist < a_dist else 2


func _update_laps_from_progress() -> void:
	# keep here if you ever go back to WP1 system,
	# but it's NOT used with LapLine now
	if player_crossed_start and player_car.current_wp == 1:
		player_laps += 1
		player_crossed_start = false

	if ai_crossed_start and ai_car.current_wp == 1:
		ai_laps += 1
		ai_crossed_start = false
		
		
func _estimate_ai_finish_time() -> int:
	var lapline: Node3D = main_scene.find_child("LapLine", true, false)
	if lapline == null:
		return ai_car.total_race_time

	# Remaining distance to finish line
	var remaining_dist: float = ai_car.distance_to_finish_line(lapline)

	# Remaining laps
	var laps_left: int = total_laps - ai_laps
	if laps_left > 0:
		var wp: Array = ai_car.waypoints
		var lap_dist: float = 0.0

		# Compute actual lap distance
		for i in range(wp.size()):
			var a: Vector3 = wp[i].global_position
			var b: Vector3 = wp[(i + 1) % wp.size()].global_position
			lap_dist += a.distance_to(b)

		remaining_dist += lap_dist * float(laps_left)

	# Smoothed speed
	var speed: float = ai_car.current_speed
	var blended_speed: float = clamp(speed * 0.85, 8.0, 120.0)

	# Time = distance / speed
	var remaining_time_ms: int = int((remaining_dist / blended_speed) * 1000)

	# Slight smoothing
	remaining_time_ms = int(remaining_time_ms * 1.05)

	return ai_car.total_race_time + remaining_time_ms

func _distance_to_next_wp(car: CarController) -> float:
	if car.waypoints.is_empty():
		return 0.0

	var next_wp := car.current_wp + 1
	if next_wp >= car.waypoints.size():
		next_wp = 0

	var wp := car.waypoints[next_wp] as Node3D
	return car.global_position.distance_to(wp.global_position)
