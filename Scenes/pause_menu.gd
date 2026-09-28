extends CanvasLayer

var is_paused := false
var volume := 40
const SETTINGS_FILE = "user://settings.cfg"

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	load_settings()              # ⭐ Load saved volume on ready
	update_volume_label()
	apply_volume()

func toggle_pause():
	is_paused = !is_paused
	get_tree().paused = is_paused
	visible = is_paused

func _on_resume_btn_pressed() -> void:
	toggle_pause()

func _on_retry_btn_pressed() -> void:
	get_tree().paused = false

	# NORMAL RACE
	if Modes.mode == "Normal Race":
		if NormalRaceManager:
			NormalRaceManager.race_active = false
			NormalRaceManager.player_car = null
			NormalRaceManager.ai_cars.clear()
		get_tree().reload_current_scene()
		return

	# DUEL
	if Modes.mode == "Duel":
		if DuelManager:
			DuelManager.duel_active = false
			DuelManager.player_car = null
			DuelManager.ai_car = null
		get_tree().reload_current_scene()
		return

	# ELIMINATION
	if Modes.mode == "Elimination":
		if EliminationManager:
			EliminationManager.race_active = false
			EliminationManager.player_car = null
			EliminationManager.ai_cars.clear()
		get_tree().reload_current_scene()
		return

	# COP CHASE
	if Modes.mode == "Cop Chase":
		if CopChaseManager:
			CopChaseManager.chase_active = false
			CopChaseManager.player_car = null
			CopChaseManager.ai_cars.clear()
		get_tree().reload_current_scene()
		return

	# ANY OTHER MODE
	get_tree().reload_current_scene()

func _on_quit_btn_pressed() -> void:
	get_tree().paused = false
	ChampionshipState.reset()
	GameMode.game_mode = ""
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_vol_up_btn_pressed() -> void:
	volume = clamp(volume + 5, 0, 100)
	update_volume_label()
	apply_volume()
	save_settings()              # ⭐ Save when volume changes

func _on_vol_down_btn_pressed() -> void:
	volume = clamp(volume - 5, 0, 100)
	update_volume_label()
	apply_volume()
	save_settings()              # ⭐ Save when volume changes

func update_volume_label():
	$Control/Panel/VolumeLabel.text = "%s: %d%%" % [
		Localization.translate("volume"),
		volume
	]

func apply_volume():
	var linear := float(volume) / 100.0
	AudioServer.set_bus_volume_db(0, linear_to_db(linear))

# ⭐ SPEED UNIT SLIDER — rewritten cleanly

func _on_kmh_btn_pressed() -> void:
	SpeedSettings.set_unit("kmh")
	Global.speed_unit = SpeedSettings.get_unit_label()
	Global.speed = SpeedSettings.convert_speed(Global.speed)
	Localization.refresh_ui()

func _on_mph_btn_pressed() -> void:
	SpeedSettings.set_unit("mph")
	Global.speed_unit = SpeedSettings.get_unit_label()
	Global.speed = SpeedSettings.convert_speed(Global.speed)
	Localization.refresh_ui()

# --- SAVE & LOAD FUNCTIONS ---

func save_settings():
	var config = ConfigFile.new()
	config.load(SETTINGS_FILE) # Load existing settings first so we don't overwrite other data if you expand later
	config.set_value("audio", "volume", volume)
	config.save(SETTINGS_FILE)

func load_settings():
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_FILE)
	if err == OK:
		volume = config.get_value("audio", "volume", 40)
