extends CanvasLayer

func _on_english_pressed() -> void:
	Localization.set_language("en")
	Localization.refresh_ui()
	_go_back()

func _on_french_pressed() -> void:
	Localization.set_language("fr")
	Localization.refresh_ui()
	_go_back()

func _on_german_pressed() -> void:
	Localization.set_language("de")
	Localization.refresh_ui()
	_go_back()

func _on_russian_pressed() -> void:
	Localization.set_language("ru")
	Localization.refresh_ui()
	_go_back()

func _on_serbo_croatian_pressed() -> void:
	Localization.set_language("sh")
	Localization.refresh_ui()
	_go_back()

func _on_turkish_pressed() -> void:
	Localization.set_language("tr")
	Localization.refresh_ui()
	_go_back()

func _go_back() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
