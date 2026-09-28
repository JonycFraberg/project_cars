extends Node

var original_texts := {}

func _ready():
	Localization.language_changed.connect(_refresh_all_ui)
	get_tree().tree_changed.connect(_refresh_all_ui)

var refresh_pending := false

func _refresh_all_ui():
	if refresh_pending:
		return
	refresh_pending = true
	await get_tree().process_frame
	refresh_pending = false

	var tree = get_tree()
	if tree == null or tree.current_scene == null:
		return

	_update_node_recursive(tree.current_scene)

func _update_node_recursive(node):
	if not is_instance_valid(node): return
	if node is Label or node is Button:
		_process_node_text(node)
	for child in node.get_children():
		_update_node_recursive(child)

func _process_node_text(node):
	var current_text = node.text
	if current_text == "": return

	if ":" in current_text:
		var parts = current_text.split(":", true, 1)
		var key_part = parts[0].strip_edges()
		var value_part = parts[1].strip_edges()

		# 1. Переводим заголовок (Country, Engine, Transmission...)
		var translated_key = Localization.translate(key_part)
		
		# 2. Пытаемся перевести всё значение целиком (USA, Four wheel drive, Compact Cars...)
		var translated_value = Localization.translate(value_part)
		
		# 3. Если значение не изменилось (нет в словаре), ищем в нем единицы измерения
		if translated_value == value_part:
			var units = ["km/h", "KG", "km/sa", "km/ч", "л.с.", "HP", "s"]
			for unit in units:
				if unit in translated_value:
					translated_value = translated_value.replace(unit, Localization.translate(unit))

		var new_text = translated_key + ": " + translated_value
		if node.text != new_text:
			node.text = new_text
		return

	# Для обычных текстов без двоеточия (названия машин, кнопки)
	# If the text changed since last time, update original
	# If the text changed since last time, update original
	if original_texts.get(node, "") != current_text:
		original_texts[node] = current_text



	var translated = Localization.translate(original_texts[node])
	if node.text != translated:
		node.text = translated
