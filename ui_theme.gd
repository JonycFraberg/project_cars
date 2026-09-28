extends Node

var global_theme: Theme

func _ready():
	var font := load("res://noto_sans.tres")

	global_theme = Theme.new()
	global_theme.default_font = font

	get_tree().root.theme = global_theme
