extends CanvasLayer

@onready var label := $Control/Label
func flash():
	label.visible = true
	label.modulate = Color(1, 1, 1, 1)
	label.scale = Vector2.ONE

	# Animation: fade + scale pop
	var tween := create_tween()
	tween.set_parallel(true)

	tween.tween_property(label, "scale", Vector2(1.4, 1.4), 0.25).set_trans(Tween.TRANS_BACK)
	tween.tween_property(label, "modulate:a", 0.0, 0.8)

	tween.set_parallel(false)
	tween.tween_callback(Callable(self, "_hide"))

func _hide():
	label.visible = false
