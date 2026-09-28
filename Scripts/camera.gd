extends Camera3D

@export var target: Node3D
@onready var forward_ref: Node3D = target.get_node("ForwardRef")

# --- Chase cam settings ---
@export var chase_distance := 8.0
@export var chase_height := 2.0
@export var smooth_speed := 10.0
@export var collision_offset := 0.2
@export var min_distance := 3.0

# --- Windshield cam (half meter in front) ---
@export var windshield_offset := Vector3(0, 1.2, -0.5)

# --- Camera mode toggle ---
var alt_cam_mode := false

# --- Rear view toggle ---
var rear_view := false

# --- Nitro shake ---
var shake_strength := 0.0


func _physics_process(delta):
	await get_tree().process_frame
	if target == null:
		return
	if target and not target.is_multiplayer_authority():
		current = false
		return
	current = true
	# ---------------------------------------------------------
	# CAMERA MODE TOGGLE
	# ---------------------------------------------------------
	if Input.is_action_just_pressed("change_cam"):
		alt_cam_mode = not alt_cam_mode

	# ---------------------------------------------------------
	# REAR VIEW TOGGLE
	# ---------------------------------------------------------
	if Input.is_action_just_pressed("rear_view"):
		rear_view = not rear_view

	# ---------------------------------------------------------
	# NITRO SHAKE (smooth sinusoidal)
	# ---------------------------------------------------------
	var nitro_on := false
	if target.has_node("Exhaust/GPUParticles3D"):
		nitro_on = target.get_node("Exhaust/GPUParticles3D").visible

	if nitro_on:
		shake_strength = lerp(shake_strength, 0.08, delta * 6.0)
	else:
		shake_strength = lerp(shake_strength, 0.0, delta * 4.0)

	var t := Time.get_ticks_msec() * 0.005
	var shake_offset := Vector3(
		sin(t * 12.0) * shake_strength,
		cos(t * 15.0) * shake_strength * 0.5,
		0.0
	)

	# ---------------------------------------------------------
	# CAR POSITION + DIRECTIONS
	# ---------------------------------------------------------
	var car_pos := target.global_transform.origin
	var forward := -target.global_transform.basis.z.normalized()
	var car_forward :Vector3 = (forward_ref.global_transform.origin - car_pos).normalized()

	# ---------------------------------------------------------
	# ALT CAMERA (windshield cam IN FRONT of car)
	# ---------------------------------------------------------
	if alt_cam_mode:
		var forward_dist := car_pos.distance_to(forward_ref.global_transform.origin)

		var base := car_pos
		base += target.global_transform.basis.x * windshield_offset.x
		base.y += windshield_offset.y
		base += car_forward * (forward_dist * 0.35)

		global_transform.origin = global_transform.origin.lerp(base + shake_offset, delta * smooth_speed)

		# Look forward normally
		look_at(car_pos + car_forward * 3.0, Vector3.UP)

		# Apply rear-view rotation if toggled
		if rear_view:
			rotate_y(deg_to_rad(180))

		return

	# ---------------------------------------------------------
	# NORMAL CHASE CAMERA
	# ---------------------------------------------------------
	var ideal_pos := car_pos - forward * chase_distance
	ideal_pos.y += chase_height

	var space := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(car_pos, ideal_pos)
	query.exclude = [target]

	var hit := space.intersect_ray(query)
	var final_pos := ideal_pos

	if hit:
		var wall_pos :Vector3 = hit.position + hit.normal * collision_offset
		var wall_dist := car_pos.distance_to(wall_pos)

		if wall_dist < min_distance:
			final_pos = car_pos - forward * min_distance
			final_pos.y += chase_height
		else:
			final_pos = wall_pos

	global_transform.origin = global_transform.origin.lerp(final_pos + shake_offset, delta * smooth_speed)

	# Look forward normally
	look_at(car_pos, Vector3.UP)

	# Apply rear-view rotation if toggled
	if rear_view:
		rotate_y(deg_to_rad(180))
