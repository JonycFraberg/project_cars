extends CanvasLayer

var volume := 40
const SETTINGS_FILE = "user://volume.cfg"

func _ready():
	load_settings()              # Load the saved volume when the scene starts
	MusicManager.play_menu_music()
	update_volume_label()
	apply_volume()


func _on_road_challenge_pressed() -> void:
	GameMode.game_mode = "Road Challenge"
	Cars.selected_class = ""   
	Cars.selected_car_name = ""
	Cars.manual_class_clear = true
	Modes.mode = "Normal Race"
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")

func _on_free_race_pressed() -> void:
	GameMode.game_mode = "Free Race"
	Cars.selected_class = ""   
	Cars.selected_car_name = ""
	Cars.manual_class_clear = true
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")

func _on_club_cups_pressed() -> void:
	GameMode.game_mode = "Club Cups"
	get_tree().change_scene_to_file("res://Scenes/championships.tscn")

func _on_multi_device_pressed() -> void:
	GameMode.game_mode = "Multi-Device"
	$LANUI.show()
	$Control.hide()

func _on_language_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/language_menu.tscn")

func _on_vol_down_pressed() -> void:
	volume = clamp(volume - 5, 0, 100)
	update_volume_label()
	apply_volume()
	save_settings()              # Save whenever volume changes

func _on_vol_up_pressed() -> void:
	volume = clamp(volume + 5, 0, 100)
	update_volume_label()
	apply_volume()
	save_settings()              # Save whenever volume changes

func update_volume_label():
	$Control/VolumeLabel.text = "%s: %d%%" % [
		Localization.translate("volume"),
		volume
	]
	
func apply_volume():
	var linear := float(volume) / 100.0
	AudioServer.set_bus_volume_db(0, linear_to_db(linear))

# --- SAVE & LOAD FUNCTIONS ---

func save_settings():
	var config = ConfigFile.new()
	config.set_value("audio", "volume", volume)
	config.save(SETTINGS_FILE)

func load_settings():
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_FILE)
	if err == OK:
		# If the file exists, grab the volume; defaults to 40 if missing
		volume = config.get_value("audio", "volume", 40)
