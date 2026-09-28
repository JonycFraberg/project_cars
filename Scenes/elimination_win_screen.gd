extends CanvasLayer

@onready var title_label := $Control/Panel/TitleLabel
@onready var retry_button := $Control/Panel/RetryBtn
@onready var quit_button := $Control/Panel/QuitBtn
@onready var player :=$AudioStreamPlayer
const WIN_SOUND = preload("res://SFX/Victory Lap.mp3")
const LOSE_SOUND = preload("res://SFX/Game Over.mp3")
func show_results(player_won: bool) -> void:
	print(ClubCups.career_progress)
	var text := ""
	if player_won:
		player.stream = WIN_SOUND
		player.play()
	else:
		player.stream = LOSE_SOUND
		player.play()
	if player_won and GameMode.game_mode=="Club Cups":
		ClubCups.save_progress()
	# WIN / LOSE
	if player_won:
		text = Localization.translate("you_win")
	else:
		text = Localization.translate("you_lose")

	# ROAD CHALLENGE PROGRESS
	if GameMode.game_mode == "Road Challenge":
		var group := RoadChallengeState.active_group
		var done: int = RoadChallengeSave.progress[group]
		var left: int = 5 - done

		if left > 0:
			# "Races left: %d / 5"
			var races_left := Localization.translate("races_left")
			text += "\n" + "%s: %d / 5" % [races_left, left]
		else:
			text += "\n" + Localization.translate("challenge_complete")

	# Apply translated text
	title_label.text = text
	visible = true

	# ⭐ CLUB CUPS REWARD BLOCK
	if player_won and GameMode.game_mode == "Club Cups":
		Cars.add_money(6000)

		if has_node("Control/Panel/MoneyLabel"):
			var money_label := $Control/Panel/MoneyLabel

			var reward := Localization.translate("reward")
			var balance := Localization.translate("balance")

			money_label.text = "%s: $6000\n%s: $%d" % [
				reward,
				balance,
				Cars.player_money
			]

			money_label.visible = true

		# Optional RewardLabel
		if has_node("Control/Panel/RewardLabel"):
			var reward_label := $Control/Panel/RewardLabel
			var reward := Localization.translate("reward")
			reward_label.text = "+ $6000 " + reward
			reward_label.visible = true


func _on_retry_btn_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func show_reward(text: String) -> void:
	if has_node("Control/Panel/RewardLabel"):
		$Control/Panel/RewardLabel.text = text
		$Control/Panel/RewardLabel.visible = true
