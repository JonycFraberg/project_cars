extends Node

var player_car_path: String = ""
var ai_car_paths: Array = []        # racer scene paths

var player_car: CarController = null
var ai_cars: Array[CarController] = []

var player_spawn: Vector3 = Vector3.ZERO
var ai_spawns: Array = []

var chase_active: bool = false

var total_time: float = 210.0       # 3 minutes
var time_left: float = 210.0

var captured_count: int = 0
var captured_total: int = 7

var hud: Node = null
var main_scene: Node = null


signal chase_failed()
signal chase_completed()
signal racer_captured(car)
signal time_left_updated(time_left)


# ============================================================
# BUILD AI LIST FROM 4 CLASSES (sport, sport_racing, urban, sedans)
# ============================================================
func build_chase_ai_paths() -> Array:
	var chase_classes = ["sport", "sport_racing", "urban", "sedans"]
	var paths: Array = []

	for cls in chase_classes:
		var list = Cars.class_lists.get(cls, [])
		for name in list:
			var path = Cars.car_scene_paths.get(name, "")
			if path != "":
				paths.append(path)

	paths.shuffle()
	return paths.slice(0, captured_total)


# ============================================================
# SPAWN CHASE
# ============================================================
func spawn_chase(scene: Node) -> void:
	hud.visible=true
	chase_active = false

	# Remove old cars
	if player_car and player_car.is_inside_tree():
		player_car.queue_free()

	for ai in ai_cars:
		if ai and ai.is_inside_tree():
			ai.queue_free()

	ai_cars.clear()

	await get_tree().process_frame


	var root := scene.get_node(TrackName.track_name)

	player_spawn = root.get_node("SpawnPoint").global_transform.origin

	ai_spawns.clear()
	for i in range(captured_total):
		ai_spawns.append(root.get_node("AISpawnPoint" + str(i+1)).global_transform.origin)

	main_scene = scene


	# PLAYER
	var player_scene := load(player_car_path)
	player_car = player_scene.instantiate() as CarController
	player_car.is_ai = false
	player_car.global_transform = root.get_node("SpawnPoint").global_transform
	player_car.controls_enabled = false
	player_car.driver_name = "Police"
	player_car.car_name = Cars.selected_car_name
	scene.add_child(player_car)

	_apply_player_color(player_car)

	await get_tree().process_frame
	await get_tree().process_frame

	if player_car.has_node("Camera3D"):
		player_car.get_node("Camera3D").current = true

	# ============================================================
	# AI RACERS — FROM sport, sport_racing, urban, sedans
	# ============================================================
	ai_car_paths = build_chase_ai_paths()
	ai_cars.clear()

	for i in range(ai_spawns.size()):
		var ai_scene := load(ai_car_paths[i])
		var ai := ai_scene.instantiate() as CarController
		scene.add_child(ai)

		if ai.has_node("Camera3D"):
			ai.get_node("Camera3D").current = false

		var spawn_node := root.get_node("AISpawnPoint" + str(i+1))
		ai.global_transform = spawn_node.global_transform
		ai.is_ai = true
		ai.controls_enabled = false

		ai.driver_name = ai.ai_names[randi() % ai.ai_names.size()]
		ai.car_name = Cars.car_scene_paths.keys()[Cars.car_scene_paths.values().find(ai_car_paths[i])]

		_apply_random_ai_color(ai)

		ai_cars.append(ai)

	await get_tree().process_frame
	await get_tree().process_frame

	# WAYPOINTS
	var wp_root := scene.find_child("Waypoints", true, false)
	player_car.set_waypoints(wp_root)

	for ai in ai_cars:
		ai.set_waypoints(wp_root)

	# RESET CHASE STATE
	captured_count = 0
	time_left = total_time

	hud = scene.get_node("CopChaseHud")
	hud.update_captured(captured_count, captured_total)
	hud.update_time_left(time_left)



	RaceResults.clear()
	var all_cars = get_all_race_cars()
	scene.get_node("Start").start_countdown(all_cars)

func on_countdown_finished():
	chase_active = true   # ⭐ THIS FIXES EVERYTHING

	player_car.controls_enabled = true
	for ai in ai_cars:
		ai.controls_enabled = true
	MusicManager.play_race_music()


# UPDATE CHASE
# ============================================================
func update_chase(delta: float) -> void:
	if not chase_active or not is_instance_valid(player_car):  
		return

	time_left -= delta
	hud.update_time_left(time_left)
	emit_signal("time_left_updated", time_left)

	if time_left <= 0.0:
		chase_active = false
		emit_signal("chase_failed")
		return


# ============================================================
# CAPTURE RACER
# ============================================================
func capture_racer(car: CarController) -> void:
	if not chase_active:
		return

	if ai_cars.has(car):
		ai_cars.erase(car)
		if car.is_inside_tree():
			car.queue_free()

		captured_count += 1
		hud.update_captured(captured_count, captured_total)
		emit_signal("racer_captured", car)

		if captured_count >= captured_total:
			chase_active = false
			player_car.controls_enabled=false
			emit_signal("chase_completed")



func get_all_race_cars() -> Array:
	var arr = []
	if player_car:
		arr.append(player_car)
	for ai in ai_cars:
		arr.append(ai)
	return arr
# ============================================================
# COLOR APPLY
func _apply_player_color(car: CarController) -> void:
	# Do NOT recolor the police interceptor
	if car.car_name == "Bartoli Cruiser Interceptor":
		return

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
