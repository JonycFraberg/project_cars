extends CanvasLayer

func _start_race_with_track(track_name: String):
	if GameMode.game_mode == "Multi-Device":
		if multiplayer.is_server():
			# Вызываем RPC из LanManager, который мы добавили ранее
			LanManager.rpc("sync_track_and_start", track_name)
	else:
		TrackName.track_name = track_name
		get_tree().change_scene_to_file("res://main.tscn")


func _on_bogota_airport_pressed():
	_start_race_with_track("BogotaAirport")	

func _on_chernobyl_pressed():
	_start_race_with_track("Chernobyl")

func _on_abu_dhabi_pressed():
	_start_race_with_track("AbuDhabi")

func _on_split_pressed():
	_start_race_with_track("Split")


func _on_back_btn_pressed() -> void:
	if Modes.mode=="Cop Chase":
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

	else: 
		get_tree().change_scene_to_file("res://Scenes/car_select.tscn")
