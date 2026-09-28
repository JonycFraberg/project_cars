extends Node

var player: AudioStreamPlayer

func _ready() -> void:
	player = AudioStreamPlayer.new()
	add_child(player)
	player.volume_db = -6


func play_menu_music() -> void:
	var path: String = "res://Songs/menu_track.mp3"

	if player.stream and player.stream.resource_path == path and player.playing:
		return

	player.stream = load(path)
	player.play()


func play_race_music() -> void:
	var path: String = "res://Songs/race_track.mp3"

	# Track-specific override using your autoload
	if TrackName.track_name == "Chernobyl":
		path = "res://Songs/chernobyl.mp3"

	if TrackName.track_name=="Split":
		path="res://Songs/split.mp3"
		
	if TrackName.track_name=="AbuDhabi":
		path="res://Songs/abu_dhabi.mp3"
	if TrackName.track_name=="NewYork":
		path="res://Songs/new_york.mp3"
	if TrackName.track_name=="LasVegas":
		path="res://Songs/las_vegas.mp3"
	# Prevent restarting same track
	if player.stream and player.stream.resource_path == path and player.playing:
		return

	player.stream = load(path)
	player.play()


func stop_music() -> void:
	player.stop()
func start_countdown() -> void:
	player.stop()
	player.stream = null
