extends CanvasLayer
@onready var player :=$AudioStreamPlayer
const WIN_SOUND = preload("res://SFX/Victory Lap.mp3")
const LOSE_SOUND = preload("res://SFX/Game Over.mp3")

func show_win(success: bool) -> void:
	print(ClubCups.career_progress)
	var text := ""
	if success:
		player.stream = WIN_SOUND
		player.play()
	else:
		player.stream = LOSE_SOUND
		player.play()
	if success and GameMode.game_mode=="Club Cups":
		ClubCups.save_progress()
	# WIN / LOSE
	if success:
		text = Localization.translate("you_win")
	else:
		text = Localization.translate("you_lose")

	# ROAD CHALLENGE PROGRESS (if needed later)
	if GameMode.game_mode == "Road Challenge":
		var group := RoadChallengeState.active_group
		var done: int = RoadChallengeSave.progress[group]
		# (You can add races_left here if you want, same as the other script)

	# ⭐ CLUB CUPS MONEY REWARD
	if success and GameMode.game_mode == "Club Cups":
		Cars.add_money(6000)

		var reward := Localization.translate("reward")
		var balance := Localization.translate("balance")

		var money_label := $Control/Panel/MoneyLabel
		money_label.text = "%s: $6000\n%s: $%d" % [
			reward,
			balance,
			Cars.player_money
		]

		money_label.visible = true

	# Apply translated title
	$Control/Panel/VBoxContainer/Label_Title.text = text
	visible = true


func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func show_reward(text: String) -> void:
	if has_node("Control/Panel/RewardLabel"):
		$Control/Panel/RewardLabel.text = text
		$Control/Panel/RewardLabel.visible = true
