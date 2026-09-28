extends Node

var mode: String
var win_screen_radar: Node
var player_car: CarController
var race_started: bool = false
var is_lan := false
var career_progress: Dictionary = {}

@onready var finish_flash := $FinishFlash
@onready var start_countdown := $Start
@onready var leaderboard := $Leaderboard if has_node("Leaderboard") else null
@onready var normal_hud := $HUD
@onready var elimination_hud := $EliminationHud
@onready var cop_chase_hud := $CopChaseHud
@onready var cop_chase_ui := $CopChaseHud/Control
@onready var radar_target_label := $HUD/Control/RadarTargetLabel

func safe_get(node: Node, path: String) -> Node:
	if node and node.has_node(path):
		return node.get_node(path)
	return null

func _ready():
	mode = Modes.mode if Modes.mode != null else ""
	if mode == "":
		mode = "Normal Race"

	Cars.load_color()
	MusicManager.play_race_music()
	career_progress = ClubCups.career_progress
	is_lan = GameMode.game_mode == "Multi-Device"
	
	if has_node("EliminationWinScreen"):
		$EliminationWinScreen.visible = false
	
	if GameMode.game_mode == "Road Challenge":
		Modes.mode = "Normal Race"
	
	var track_name := TrackName.track_name
	if not TrackRegistry.tracks.has(track_name):
		push_error("Track not registered: " + track_name)
		return

	var track_file: String = TrackRegistry.tracks[track_name]
	var track_scene := load(track_file)

	if track_scene:
		var track_instance = track_scene.instantiate()
		track_instance.name = track_name
		add_child(track_instance)
		await get_tree().process_frame
	else:
		push_error("Track file missing: " + track_file)
		return

	if is_lan:
		_spawn_lan_player()
	else:
		if mode == "Duel":
			_setup_duel()
		elif mode.to_lower() == "normal race":
			_setup_normal_race()
		elif mode == "Elimination":
			_setup_elimination()
		elif mode == "Cop Chase":
			_setup_cop_chase()
		else:
			_spawn_player_free_drive()

	if mode == "Radar Race":
		radar_target_label.text = "Target: %d km/h" % Cars.get_radar_target_speed()
		var ws_scene = load("res://Scenes/win_screen_radar.tscn")
		win_screen_radar = ws_scene.instantiate()
		add_child(win_screen_radar)
		win_screen_radar.visible = false
		radar_target_label.visible = true
	else:
		radar_target_label.visible = false

	finish_flash.visible = false
	if leaderboard:
		leaderboard.visible = false

func _process(delta):
	if not race_started:
		return
	if player_car:
		var speed = player_car.velocity.length()
		rpc_id(player_car.get_multiplayer_id(), "update_speed_display", speed)
	match mode:
			"Duel": DuelManager.update_duel()
			"Radar Race": pass
			_:
				if mode.to_lower() == "normal race":
					if is_lan:
						if player_car and is_instance_valid(player_car):
							NormalRaceManager.update_race()
					else:
						NormalRaceManager.update_race()
				elif mode == "Elimination":
					EliminationManager.update_race()
				elif mode == "Cop Chase":
					CopChaseManager.update_chase(delta)

func _spawn_lan_player():
	var path := Cars.selected_car
	var my_id = multiplayer.get_unique_id()
	var scene := load(path)
	player_car = scene.instantiate()
	
	# Имя узла должно быть ID, чтобы синхронизатор нашел его у других
	player_car.name = str(my_id)
	
	setup_multiplayer_sync(player_car)
	player_car.set_multiplayer_authority(my_id)
	
	# true во втором аргументе add_child предотвращает изменение имени на @ID@...
	add_child(player_car, true)
	_apply_color_to_car(player_car, Cars.selected_color)

	var root := get_node(TrackName.track_name)
	var spawn = safe_get(root, "SpawnPoint") if my_id == 1 else safe_get(root, "AISpawnPoint" + str(my_id % 7))
	if spawn:
		player_car.global_transform = spawn.global_transform

	_force_player_camera()
	rpc("spawn_remote_player", my_id, path)

@rpc("any_peer")
func spawn_remote_player(id, car_path):
	if has_node(str(id)): return # Уже создан
	
	var scene := load(car_path)
	if scene == null: return
	
	var car = scene.instantiate()
	car.name = str(id)
	
	setup_multiplayer_sync(car)
	car.set_multiplayer_authority(id)
	
	add_child(car, true)
	
	var root := get_node(TrackName.track_name)
	var spawn_index = (id % 7) + 1 
	var spawn := safe_get(root, "AISpawnPoint" + str(spawn_index))
	if spawn:
		car.global_transform = spawn.global_transform

func setup_multiplayer_sync(car_node: Node3D):
	if car_node.has_node("MultiplayerSynchronizer"): return
	var sync = MultiplayerSynchronizer.new()
	sync.name = "MultiplayerSynchronizer"
	var config = SceneReplicationConfig.new()
	config.add_property(":sync_transform")
	config.add_property(":sync_velocity")
	sync.replication_config = config
	car_node.add_child(sync)

func _force_player_camera():
	if not player_car: return
	if player_car.has_node("Camera3D"):
		player_car.get_node("Camera3D").current = true

func _apply_color_to_car(car: CarController, color: Color):
	if car.has_node("ModelRoot/Body"):
		var body = car.get_node("ModelRoot/Body")
		for child in body.get_children():
			if child is MeshInstance3D:
				var mat = child.get_active_material(0)
				if mat: mat.albedo_color = color

func _screech_to_halt():
	for node in get_tree().get_nodes_in_group("cars"):
		if node is CarController:
			node.controls_enabled = false
			node.hard_frozen = true
			node.velocity = Vector3.ZERO

# --- ОСТАЛЬНЫЕ ВАШИ ФУНКЦИИ БЕЗ ИЗМЕНЕНИЙ ---
func _setup_duel():
	var root := get_node(TrackName.track_name)
	var psp := safe_get(root, "SpawnPoint")
	var asp := safe_get(root, "AISpawnPoint")
	DuelManager.player_spawn = psp.global_position if psp else Vector3.ZERO
	DuelManager.ai_spawn = asp.global_position if asp else DuelManager.player_spawn
	DuelManager.player_car_path = Cars.selected_car
	if GameMode.game_mode == "Club Cups":
		Cars.apply_championship_class(ChampionshipState.active_cup)
		var cup_id := ChampionshipState.active_cup
		var filtered := ClubCups.get_available_cars(cup_id)
		if filtered.size() > 0:
			var chosen := filtered[randi() % filtered.size()]
			DuelManager.ai_car_path = Cars.car_scene_paths[chosen]
			Cars.selected_ai_car_name = chosen
		else:
			DuelManager.ai_car_path = Cars.selected_car
	else:
		DuelManager.ai_car_path = Cars.selected_ai_car if Cars.selected_ai_car != "" else Cars.selected_car
	DuelManager.spawn_duel(self)
	DuelManager.main_scene = self
	player_car = DuelManager.player_car
	_force_player_camera()
	start_countdown.start_countdown(DuelManager.get_all_race_cars())

func _setup_normal_race():
	if not is_lan:
		if player_car: player_car.queue_free()
		player_car = null
	var root := get_node(TrackName.track_name)
	var spawn := safe_get(root, "SpawnPoint")
	NormalRaceManager.player_spawn = spawn.global_position if spawn else Vector3.ZERO
	NormalRaceManager.player_car_path = Cars.selected_car
	NormalRaceManager.ai_spawns = []
	for i in range(1, 8):
		var ai_sp := safe_get(root, "AISpawnPoint" + str(i))
		NormalRaceManager.ai_spawns.append(ai_sp.global_position if ai_sp else NormalRaceManager.player_spawn)
	Cars.apply_championship_class(ChampionshipState.active_cup)
	if GameMode.game_mode == "Club Cups":
		var filtered_names = ClubCups.get_available_cars(ChampionshipState.active_cup)
		var filtered_paths = []
		for name in filtered_names:
			if Cars.car_scene_paths.has(name): filtered_paths.append(Cars.car_scene_paths[name])
		NormalRaceManager.ai_car_paths = filtered_paths
	else:
		NormalRaceManager.ai_car_paths = Cars.get_ai_paths_for_class(Cars.selected_class)
	NormalRaceManager.spawn_race(self)
	player_car = NormalRaceManager.player_car
	_force_player_camera()
	start_countdown.start_countdown(NormalRaceManager.get_all_race_cars())
	start_countdown.connect("countdown_finished", Callable(NormalRaceManager, "on_countdown_finished"))

func _setup_elimination():
	if player_car: player_car.queue_free()
	player_car = null
	normal_hud.visible = false
	var root := get_node(TrackName.track_name)
	var spawn := safe_get(root, "SpawnPoint")
	EliminationManager.player_spawn = spawn.global_position if spawn else Vector3.ZERO
	EliminationManager.ai_spawns = []
	for i in range(1, 8):
		var ai_sp := safe_get(root, "AISpawnPoint" + str(i))
		EliminationManager.ai_spawns.append(ai_sp.global_position if ai_sp else EliminationManager.player_spawn)
	EliminationManager.player_car_path = Cars.selected_car
	EliminationManager.spawn_race(self)
	player_car = EliminationManager.player_car
	_force_player_camera()
	start_countdown.start_countdown(EliminationManager.get_all_race_cars())
	start_countdown.connect("countdown_finished", Callable(EliminationManager, "on_countdown_finished"))

func _setup_cop_chase():
	if player_car: player_car.queue_free()
	player_car = null
	normal_hud.visible = false
	CopChaseManager.player_car_path = Cars.selected_car
	CopChaseManager.ai_car_paths = Cars.get_ai_paths_for_class(Cars.selected_class)
	CopChaseManager.spawn_chase(self)
	player_car = CopChaseManager.player_car
	_force_player_camera()
	start_countdown.start_countdown(CopChaseManager.get_all_race_cars())
	start_countdown.connect("countdown_finished", Callable(CopChaseManager, "on_countdown_finished"))

func _spawn_player_free_drive():
	var path := Cars.selected_car
	var scene := load(path)
	player_car = scene.instantiate()
	add_child(player_car)
	_apply_color_to_car(player_car, Cars.selected_color)
	var root := get_node(TrackName.track_name)
	var spawn := safe_get(root, "SpawnPoint")
	if spawn: player_car.global_transform = spawn.global_transform
	_force_player_camera()

func _input(event):
	if event.is_action_pressed("pause_menu"):
		if has_node("PauseMenu"): $PauseMenu.toggle_pause()
