extends Node

var save_path := "user://road_challenge.json"

var unlocked := {
	"suv": true,
	"muscle": false,
	"compact": false,
	"sedans": false,
	"urban": false,
	"sport": false,
	"sport_racing": false,
	"supercars": false,
	"track_cars": false
}

var progress := {
	"suv": 0,
	"muscle": 0,
	"compact": 0,
	"sedans": 0,
	"urban": 0,
	"sport": 0,
	"sport_racing": 0,
	"supercars": 0,
	"track_cars": 0
}

# ============================================================
# SAVE / LOAD
# ============================================================

func save_progress():
	var data = {
		"unlocked": unlocked,
		"progress": progress
	}
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()

func load_progress():
	if not FileAccess.file_exists(save_path):
		save_progress() # create default save file
		return
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		var text = file.get_as_text()
		file.close()
		var result = JSON.parse_string(text)
		if typeof(result) == TYPE_DICTIONARY:
			if result.has("unlocked"):
				unlocked = result["unlocked"]
			if result.has("progress"):
				progress = result["progress"]

# ============================================================
# UNLOCK LOGIC
# ============================================================

func unlock_next_group(group_id: String):
	var order := [
		"suv",
		"muscle",
		"compact",
		"sedans",
		"urban",
		"sport",
		"sport_racing",
		"supercars",
		"track_cars"
	]

	var idx := order.find(group_id)
	if idx == -1:
		return

	# Require ALL previous groups to be completed (5 wins each)
	for i in range(idx + 1):
		var g : String = order[i]
		if progress[g] < 5:
			return

	# Unlock the next group
	if idx < order.size() - 1:
		unlocked[order[idx + 1]] = true
		save_progress()  # auto-save after unlocking
