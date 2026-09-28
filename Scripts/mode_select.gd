extends CanvasLayer

func _ready():
	MusicManager.play_menu_music()
	if GameMode.game_mode == "Club Cups":
		$Control/CopChaseBtn.hide()
		
		# Moved definitions up here first!
		var cup_id = ChampionshipState.active_cup
		var progress = ClubCups.career_progress.get(cup_id, {})

		# Now 'progress' safely exists for this check
		var complete :bool= (
			progress.get("normal", false)
			and progress.get("duel", false)
			and progress.get("elimination", false)
			and progress.get("radar", false)
		)

		$Control/NormalRaceTrophy.text = "🏆" if progress.get("normal", false) else ""
		$Control/EliminationTrophy.text = "🏆" if progress.get("elimination", false) else ""
		$Control/DuelTrophy.text = "🏆" if progress.get("duel", false) else ""
		$Control/RadarTrophy.text = "🏆" if progress.get("radar", false) else ""
		

func _on_radar_race_btn_pressed() -> void:
	Modes.mode = "Radar Race"
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")
	Cars.dealership_mode=false

func _on_duel_btn_pressed() -> void:
	Modes.mode = "Duel"
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")
	Cars.dealership_mode=false

func _on_normal_race_btn_pressed() -> void:
	Modes.mode = "Normal Race"
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")
	Cars.dealership_mode=false

func _on_elimination_btn_pressed() -> void:
	Modes.mode = "Elimination"
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")
	Cars.dealership_mode=false

func _on_back_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	ChampionshipState.reset()
	GameMode.game_mode = ""

func _on_cop_chase_btn_pressed() -> void:
	Modes.mode = "Cop Chase"

	# Fixed: your actual police car scene
	Cars.selected_car = "res://Scenes/granturismo_police.tscn"

	# Fixed: your actual car name
	Cars.selected_car_name = "Bartoli Cruiser Interceptor"

	# Go straight into the race
	get_tree().change_scene_to_file("res://Scenes/track_select.tscn")
	
