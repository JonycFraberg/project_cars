extends CharacterBody3D

@export var base_speed: float = 18.0
@export var accel: float = 4.0
@export var brake_force: float = 10.0
@export var max_speed: float = 22.0

@export var ray_length: float = 6.0
@export var lane_offset: float = 3.0
@export var lane_switch_cooldown: float = 3.0

var current_speed: float = 0.0
var lane_dir: int = 0
var cooldown: float = 0.0

func _ready():
	lane_dir = 0
	cooldown = 0.0

func _physics_process(delta):
	cooldown -= delta

	var forward = -transform.basis.z
	var space = get_world_3d().direct_space_state

	# Raycast forward to detect cars or obstacles
	var query = PhysicsRayQueryParameters3D.create(
		global_transform.origin,
		global_transform.origin + forward * ray_length
	)
	query.exclude = [self]

	var hit = space.intersect_ray(query)

	if hit:
		# Slow down smoothly
		current_speed = lerp(current_speed, 0.0, brake_force * delta)

		# Try lane switch if possible
		if cooldown <= 0.0:
			try_lane_switch(space)
	else:
		# Accelerate back to cruising speed
		current_speed = lerp(current_speed, base_speed, accel * delta)
		current_speed = min(current_speed, max_speed)

	# Apply movement
	velocity = forward * current_speed
	move_and_slide()
	# --- COLLISION WITH ANY CarController ---

	

func try_lane_switch(space):
	var left_pos = global_transform.origin + transform.basis.x * -lane_offset
	var right_pos = global_transform.origin + transform.basis.x * lane_offset

	var forward = -transform.basis.z

	var left_query = PhysicsRayQueryParameters3D.create(
		left_pos,
		left_pos + forward * ray_length
	)
	left_query.exclude = [self]

	var right_query = PhysicsRayQueryParameters3D.create(
		right_pos,
		right_pos + forward * ray_length
	)
	right_query.exclude = [self]

	var left_clear = space.intersect_ray(left_query) == null
	var right_clear = space.intersect_ray(right_query) == null

	if left_clear:
		lane_dir = -1
		cooldown = lane_switch_cooldown
		translate(transform.basis.x * -lane_offset)
	elif right_clear:
		lane_dir = 1
		cooldown = lane_switch_cooldown
		translate(transform.basis.x * lane_offset)
