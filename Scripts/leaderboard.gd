extends CanvasLayer

@onready var title_label: Label = $Control/Panel/TitleLabel
@onready var entries: VBoxContainer = $Control/VBoxContainer
@onready var retry_button: Button = $Control/RetryBtn
@onready var quit_button: Button = $Control/QuitBtn
@onready var player :=$AudioStreamPlayer
const WIN_SOUND = preload("res://SFX/Victory Lap.mp3")
const LOSE_SOUND = preload("res://SFX/Game Over.mp3")

func show_results(player_won: bool) -> void:
	# Title\
	print(ClubCups.career_progress)
	if player_won:
		player.stream = WIN_SOUND
		player.play()
	else:
		player.stream = LOSE_SOUND
		player.play()
	if player_won:
		Localization.set_text(title_label, "YOU WIN!")
	else:
		Localization.set_text(title_label, "YOU LOSE!")
	if player_won and GameMode.game_mode=="Club Cups":
		ClubCups.save_progress()


	# Road Challenge
	if GameMode.game_mode == "Road Challenge":
		var group := RoadChallengeState.active_group
		var done: int = RoadChallengeSave.progress[group]
		var left: int = 5 - done

		if left > 0:
			Localization.set_text(title_label, "Races left: %d / 5" % left)
		else:
			Localization.set_text(title_label, "Challenge Complete!")


	# Clear old entries
	for child in entries.get_children():
		child.queue_free()

	# Get raw results
	# Already sorted by _end_race()
	var raw: Array = RaceResults.results


	# Display sorted results
	for i: int in raw.size():
		var r: Dictionary = raw[i]
		var line := Label.new()
		line.text = "%d. %s — %s" % [
			i + 1,
			r["name"],
			r["car"],
		]
		entries.add_child(line)

	# Club Cups reward
	if player_won and GameMode.game_mode == "Club Cups":
		Cars.add_money(6000)
		var money_label: Label = $Control/Panel/MoneyLabel
		Localization.set_text(money_label, "Reward: $6000\nBalance: $" + str(Cars.player_money))

	visible = true


func _format_time(ms: int) -> String:
	var total_seconds: float = ms / 1000.0
	var minutes: int = int(total_seconds / 60)
	var seconds: float = total_seconds - minutes * 60
	return "%02d:%05.2f" % [minutes, seconds]


func _on_retry_btn_pressed() -> void:
	reset()
	get_tree().reload_current_scene()


func _on_quit_btn_pressed() -> void:
	reset()
	if GameMode.game_mode == "Road Challenge":
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/mode_select.tscn")


func reset() -> void:
	title_label.text = ""
	for child in entries.get_children():
		child.queue_free()
	visible = false
func show_reward(text: String):
	if has_node("Control/Panel/RewardLabel"):
		$Control/Panel/RewardLabel.text = text
		$Control/Panel/RewardLabel.visible = true
