extends Node

var player_car_path: String = ""
var ai_car_paths: Array = []        # 7 AI car scene paths

var player_car: CarController = null
var ai_cars: Array[CarController] = []

var player_spawn: Vector3 = Vector3.ZERO
var ai_spawns: Array = []

var race_active: bool = false

var elimination_interval: float = 20.0
var elimination_timer: float = 20.0

var hud: Node = null
var main_scene: Node = null
var last_sorted: Array = []
var last_last_car: CarController = null
var last_last_confirm_count: int = 0
var required_last_confirm: int = 2   # must be last for 2 eliminations in a row
var car_laps: Dictionary = {}
var last_wp: Dictionary = {}


signal player_eliminated()
signal ai_eliminated(car)
signal elimination_win(car)
signal elimination_timer_updated(time_left)

func spawn_race(scene: Node) -> void:
	race_active = false
	RaceResults.clear()
	# Remove old cars
	if player_car and player_car.is_inside_tree():
		player_car.queue_free()

	for ai in ai_cars:
		if ai and ai.is_inside_tree():
			ai.queue_free()

	ai_cars.clear()
	
	await get_tree().process_frame
	if GameMode.game_mode == "Club Cups":
		ai_car_paths = Cars.get_ai_paths_for_class(ChampionshipState.active_cup)
	else:
		Cars.apply_auto_class_if_not_club()
		ai_car_paths = Cars.get_ai_paths_for_class(Cars.selected_class)

	var root := scene.get_node(TrackName.track_name)

	player_spawn = root.get_node("SpawnPoint").global_transform.origin

	ai_spawns.clear()
	for i in range(7):
		ai_spawns.append(root.get_node("AISpawnPoint" + str(i+1)).global_transform.origin)

	main_scene = scene
	hud = scene.get_node("EliminationHud")



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

	# AI
	ai_cars.clear()
	# FIX: Auto-detect class for any mode that is NOT Club Cups
	Cars.apply_auto_class_if_not_club()


	for i in range(ai_spawns.size()):
		var path :String= ai_car_paths[i % ai_car_paths.size()]
		var ai_scene := load(path)
		var ai := ai_scene.instantiate() as CarController
		scene.add_child(ai)

		if ai.has_node("Camera3D"):
			ai.get_node("Camera3D").current = false

		var spawn_node := root.get_node("AISpawnPoint" + str(i+1))
		ai.global_transform = spawn_node.global_transform
		ai.is_ai = true
		ai.controls_enabled =false

		ai.driver_name = ai.ai_names[randi() % ai.ai_names.size()]
		var car_name := ""
		for name in Cars.car_scene_paths.keys():
			if Cars.car_scene_paths[name] == path:
				car_name = name
				break
		_apply_random_ai_color(ai)

		ai_cars.append(ai)

	await get_tree().process_frame
	await get_tree().process_frame

	# WAYPOINTS
	var wp_root := scene.find_child("Waypoints", true, false)
	player_car.set_waypoints(wp_root)

	for ai in ai_cars:
		ai.set_waypoints(wp_root)

	# START
		# INIT LAPS
	car_laps.clear()
	car_laps[player_car] = 0
	for ai in ai_cars:
		car_laps[ai] = 0
	
	last_wp.clear()
	last_wp[player_car] = 0
	for ai in ai_cars:
		last_wp[ai] = 0


	elimination_timer = elimination_interval


	hud.update_position(1, ai_cars.size() + 1)
	hud.update_elimination_timer(elimination_timer)


	var all_cars = get_all_race_cars()
	scene.get_node("Start").start_countdown(all_cars)

func update_race() -> void:
	if not race_active or not is_instance_valid(player_car):  
		return

	# Take ONE stable snapshot for this frame
	var sorted := _sorted_cars()
	var player_pos := _position_from_sorted(sorted)

	hud.update_position(player_pos, ai_cars.size() + 1)

	elimination_timer -= get_process_delta_time()
	hud.update_elimination_timer(elimination_timer)

	if elimination_timer <= 0.0:
		_do_elimination(sorted)  # use SAME snapshot
		elimination_timer = elimination_interval
func on_countdown_finished():
	race_active = true
	player_car.controls_enabled = true
	for ai in ai_cars:
		ai.controls_enabled = true
	MusicManager.play_race_music()

func _do_elimination(sorted: Array) -> void:
	if ai_cars.size() + 1 <= 1:
		return

	if sorted.is_empty():
		return

	var last: CarController = sorted[-1]

	# PLAYER eliminated
	if last == player_car:
		race_active = false
		player_car.controls_enabled = false
		player_car.current_speed = 0
		emit_signal("player_eliminated")
		return

	# AI eliminated
	ai_cars.erase(last)
	if last.is_inside_tree():
		last.queue_free()

	emit_signal("ai_eliminated", last)

	# WIN
	# WIN
	if ai_cars.size() == 0:
		race_active = false
		player_car.controls_enabled = false
		player_car.current_speed = 0
		emit_signal("elimination_win", player_car)


func get_all_race_cars() -> Array:
	var arr = []
	if player_car:
		arr.append(player_car)
	for ai in ai_cars:
		arr.append(ai)
	return arr

func _position_from_sorted(sorted: Array) -> int:
	for i in range(sorted.size()):
		if sorted[i] == player_car:
			return i + 1
	return 1

func _calculate_position() -> int:
	var sorted := _sorted_cars()

	for i in range(sorted.size()):
		if sorted[i] == player_car:
			return i + 1

	return 1

func _sorted_cars() -> Array:
	if not is_instance_valid(player_car) or player_car.waypoints.is_empty():
		  			
					return []
	var total_wp := player_car.waypoints.size()
	var cars := []

		# Detect wrap-around (WP_last → WP_0)
	if player_car.current_wp == 0 and last_wp[player_car] == total_wp - 1:
		car_laps[player_car] += 1

	for ai in ai_cars:
		if ai.current_wp == 0 and last_wp[ai] == total_wp - 1:
			car_laps[ai] += 1


	# BUILD DATA
	cars.append({
		"car": player_car,
		"progress": car_laps[player_car] * total_wp + player_car.current_wp,
		"dist": _distance_to_next_wp(player_car)
	})

	for ai in ai_cars:
		cars.append({
			"car": ai,
			"progress": car_laps[ai] * total_wp + ai.current_wp,
			"dist": _distance_to_next_wp(ai)
		})

	# SORT: higher progress first, then closer to next WP
	cars.sort_custom(func(a, b):
		if a["progress"] != b["progress"]:
			return a["progress"] > b["progress"]
		return a["dist"] < b["dist"]
	)

	var result: Array = []
	for c in cars:
		result.append(c["car"])
	# Update last waypoint snapshot
	last_wp[player_car] = player_car.current_wp
	for ai in ai_cars:
		last_wp[ai] = ai.current_wp

	return result

	
func _distance_to_next_wp(car: CarController) -> float:
	if car.waypoints.is_empty():
		return 0.0

	var next_wp := car.current_wp + 1
	if next_wp >= car.waypoints.size():
		next_wp = 0

	var wp := car.waypoints[next_wp] as Node3D
	return car.global_position.distance_to(wp.global_position)


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
