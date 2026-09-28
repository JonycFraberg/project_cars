extends CharacterBody3D

var yeet_timer := 0.0
var yeet_force := Vector3.ZERO
var yeeting := false

func _on_area_3d_body_entered(body):
	if body is CarController:
		# Disable collisions IMMEDIATELY
		collision_layer = 0
		collision_mask = 0

		# Clear velocity so no slide-collision memory remains
		velocity = Vector3.ZERO

		# Smooth YEET direction
		var dir: Vector3 = (global_position - body.global_position).normalized()
		yeet_force = dir * 2.0 + Vector3.UP * 3.0

		yeet_timer = 0.1
		yeeting = true

func _physics_process(delta):
	if yeeting:
		yeet_timer -= delta

		# DO NOT USE move_and_slide() anymore
		# Just manually move the prop
		global_position += yeet_force * delta

		if yeet_timer <= 0.0:
			queue_free()
