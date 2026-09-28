extends Node

func on_race_finished(player_won: bool):
	if not player_won:
		return

	var group := RoadChallengeState.active_group
	RoadChallengeSave.progress[group] += 1

	if RoadChallengeSave.progress[group] >= 5:
		RoadChallengeSave.unlock_next_group(group)
