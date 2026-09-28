extends Node

var peer: ENetMultiplayerPeer
var is_host := false

signal status_changed(msg)

const PORT := 9000
const MAX_PLAYERS := 4

# Переменная для хранения выбранной трассы на уровне сети
var synced_track_name : String = ""

func start_host():
	is_host = true
	peer = ENetMultiplayerPeer.new()

	var result := peer.create_server(PORT, MAX_PLAYERS)
	print("Host result: ", result)

	if result != OK:
		emit_signal("status_changed", "Failed to start host")
		return

	multiplayer.multiplayer_peer = peer
	emit_signal("status_changed", "Hosting...")

	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func join_host(ip: String):
	is_host = false
	peer = ENetMultiplayerPeer.new()

	var result := peer.create_client(ip, PORT)
	print("Join result: ", result)

	if result != OK:
		emit_signal("status_changed", "Failed to connect")
		return

	multiplayer.multiplayer_peer = peer
	emit_signal("status_changed", "Connecting...")

	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func _on_peer_connected(id):
	if is_host:
		print("Client joined:", id)
		emit_signal("status_changed", "Player %d joined" % id)
		call_deferred("_host_start_car_select", id)
	else:
		print("Connected to host")
		emit_signal("status_changed", "Connected to host")

@rpc("authority")
func client_go_to_car_select():
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")

func _on_peer_disconnected(id):
	if is_host:
		emit_signal("status_changed", "Player %d left" % id)
	else:
		emit_signal("status_changed", "Disconnected from host")

func _host_start_car_select(id):
	# Хост сам переходит и отправляет клиента
	get_tree().change_scene_to_file("res://Scenes/car_select.tscn")
	rpc_id(id, "client_go_to_car_select")

@rpc("authority", "call_local", "reliable")
func sync_track_and_start(track_name: String):
	print("Сетевой старт трассы: ", track_name)
	TrackName.track_name = track_name
	RoadChallengeState.active_track = track_name
	# Меняем сцену у всех одновременно
	get_tree().change_scene_to_file("res://main.tscn")
