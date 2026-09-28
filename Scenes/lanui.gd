extends CanvasLayer

@onready var host_button  = $Control/HostButton
@onready var join_button  = $Control/JoinButton
@onready var ip_field     = $Control/IPField
@onready var back_button  = $Control/BackButton
@onready var status_label = $Control/StatusLabel

func _ready():
	hide()
	host_button.pressed.connect(_on_host_pressed)
	join_button.pressed.connect(_on_join_pressed)
	back_button.pressed.connect(_on_back_pressed)
	$Control/IPField.placeholder_text=Localization.translate("enter_ip_of_host_to_join_game")

	# Listen to LANManager status updates
	if LanManager.has_signal("status_changed"):
		LanManager.status_changed.connect(_on_status_changed)

	status_label.text = ""
	
	


func _on_host_pressed():
	status_label.text = "Hosting game..."
	LanManager.start_host()

func _on_join_pressed():
	var ip :String= ip_field.text.strip_edges()
	if ip == "":
		status_label.text = "Enter host IP"
		return

	status_label.text = "Joining %s..." % ip
	LanManager.join_host(ip)

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_status_changed(msg: String):
	status_label.text = msg
