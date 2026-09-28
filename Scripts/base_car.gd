class_name CarController
extends CharacterBody3D

const GRAVITY := 30.0
const ENGINE_BRAKE := 0.5
const DRAG := 0.1
const HARD_LIMIT_KMH := 400.0
const HARD_LIMIT := HARD_LIMIT_KMH / 3.6
var display_hp := 0.0
var display_weight := 0.0


# --- ROLE FLAGS ---
var is_ai: bool = false
var waypoint_root: Node3D = null
var waypoints: Array[Node] = []
var current_wp: int = 0
var hard_frozen := false
static var used_ai_names := []
var speed_samples := []
var avg_speed := 0.0
var distance_travelled:=0.0
var finished_time: int = -1
var reversing: bool = false
var reverse_speed_limit := 40.0 / 3.6  # 40 km/h in m/s


@export var sync_velocity: Vector3
@export var sync_transform: Transform3D


# --- AI INPUT ---
var ai_throttle: float = 0.0
var ai_brake: float = 0.0
var ai_steer: float = 0.0
static var ai_names := [
	"David", "Takashi", "Ricco", "Chris", "Petar", "Nina",
	"Steve", "Linus", "Chris", "Jesse", "Dimitri", "Mirko",
	"Abdullah", "Will", "Jimmy M.", "Gandi", "Tiffany", "Hoff", "Jake", "Britney","Laura","Francesca","Looping","Alex","Math","Sam","Gordon"
]

# --- PLAYER INPUT ---
var throttle_input: float = 0.0
var brake_input: float = 0.0
var steer_input: float = 0.0

# --- CAR STATS ---
var mass := 1200.0
var zero_to_hundred := 7.0
var top_speed_kmh := 200.0
var top_speed := 60.0
var turn_speed := 2.5
var brake_strength := 20.0
var lateral_friction := 1.2
var driver_name: String = "Unknown"
var car_name: String = ""





var transmission := "Front wheel drive" # "Front wheel drive", "Rear wheel drive", "Four wheel drive"
var is_diesel := false
var nitro_time: float = 0.0
var nitro_cooldown: float = 0.0
var nitro_active: bool = false


var horsepower := 150.0
var max_rpm := 6500.0
var idle_rpm := 900.0
var rpm := 900.0
var torque := 0.0

var gear_count := 6
var gear_ratios := [3.5, 2.1, 1.5, 1.2, 1.0, 0.82]
var current_speed: float = 0.0
var current_gear := 1
var shift_up_rpm := 6200
var shift_down_rpm := 2000
var total_race_time: int = 0



var acceleration_calc := 0.0
var steering := 0.0

var drifting := false
var drift_factor := 0.0
var boost := false
var nitro_top_speed_multiplier := 1.07

var performance_points := 0
var debug_enabled := true
var handling_type := "balanced"

var controls_enabled: bool = true

@export var spawn_yaw_deg: float = 0.0

@onready var car_model := $ModelRoot
@onready var forward_ref := $ForwardRef
@onready var nitro := $Exhaust/GPUParticles3D

# --- OVERTAKING ---
var ai_overtake_offset: float = 0.0
var ai_overtake_side: float = 0.0 # -1 left, +1 right

func apply_stats() -> void:
	# --- APPLY UPGRADES FIRST (Arcade‑clean behavior) ---
	if GameMode.game_mode == "Club Cups" and Cars.upgrades.has(car_name):
		var u = Cars.upgrades[car_name]
		Cars.load_upgrades()

		# Weight Reduction → improves acceleration + top speed slightly
		if u["weight"] > 0:
			var w = u["weight"]
			mass *= (1.0 - 0.05 * w)                 # lighter car
			zero_to_hundred *= (1.0 - 0.04 * w)     # faster 0–100
			
		# Engine Tune → improves HP + top speed
		if u["engine"] > 0:
			var e = u["engine"]
			horsepower *= (1.0 + 0.06 * e)          # more HP
			top_speed_kmh *= (1.0 + 0.03 * e)       # bigger top speed gain

		# Steering Upgrade → improves handling only
		if u["steering"] > 0:
			var s = u["steering"]
			turn_speed *= (1.0 + 0.08 * s)
			lateral_friction *= (1.0 + 0.05 * s)

		# Brake Upgrade → improves braking only
		if u["brakes"] > 0:
			var b = u["brakes"]
			brake_strength *= (1.0 + 0.10 * b)

	# --- ORIGINAL STATS CALC ---
	acceleration_calc = (27.78 / zero_to_hundred) * 2.3
	torque = (horsepower * 5252.0) / max_rpm

	if is_diesel:
		torque *= 1.6

	top_speed = top_speed_kmh / 3.6

	performance_points = round(
		(top_speed_kmh * 1.5)
		+ (100.0 / zero_to_hundred)
		+ ((horsepower / mass) * 700.0)
	)

func apply_handling_profile() -> void:
	match handling_type:
		"light_sport":
			turn_speed *= 1.25
			lateral_friction *= 1.15
			brake_strength *= 1.1
			mass *= 0.95
		"heavy_muscle":
			turn_speed *= 0.75
			lateral_friction *= 0.85
			brake_strength *= 0.9
			mass *= 1.15
		"luxury_boat":
			turn_speed *= 0.65
			lateral_friction *= 0.8
			brake_strength *= 0.85
			mass *= 1.2
		"awd_grip":
			turn_speed *= 1.05
			lateral_friction *= 1.2
			brake_strength *= 1.1
		"fwd_hot_hatch":
			turn_speed *= 1.15
			lateral_friction *= 1.05
		"supercar":
			turn_speed *= 1.2
			lateral_friction *= 1.3
			brake_strength *= 1.25
			mass *= 0.9
		"balanced":
			pass

func _ready() -> void:
	apply_stats()
	apply_handling_profile()
	nitro.hide()
	floor_stop_on_slope=false
	if is_ai:
		# Build a fresh pool if empty
		if used_ai_names.is_empty():
			used_ai_names = ai_names.duplicate()

		# Pick a unique name
		var idx := randi() % used_ai_names.size()
		driver_name = used_ai_names[idx]

		# Remove it so no other AI can use it
		used_ai_names.remove_at(idx)
	else:
		driver_name = "Player"


func update_gears(speed_kmh: float) -> void:
	if rpm > shift_up_rpm and current_gear < gear_count:
		current_gear += 1
		rpm *= 0.6

	if rpm < shift_down_rpm and current_gear > 1:
		current_gear -= 1
		rpm *= 1.3

	current_gear = clamp(current_gear, 1, gear_count)

func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():
		sync_velocity = velocity
		sync_transform = global_transform
	if not is_multiplayer_authority():
		velocity = sync_velocity
		global_transform = sync_transform
		return
	speed_samples.append(current_speed)
	if speed_samples.size() > 60: # last 1 second
		speed_samples.pop_front()

	var sum := 0.0
	for s in speed_samples:
		sum += s
	avg_speed = sum / speed_samples.size()

	if not controls_enabled:
		if not is_on_floor():
			velocity.y -= GRAVITY * delta
		move_and_slide()
		velocity.y = -0.01
		return

	# --- UPDATE WAYPOINT FIRST ---
	# --- UPDATE WAYPOINT FIRST ---
	update_waypoint()
	# Smooth the distance to prevent jitter


	if is_ai:
		_update_ai_inputs(delta)
		throttle_input = ai_throttle
		brake_input = ai_brake
		steer_input = ai_steer
	else:
		throttle_input = Input.get_action_strength("accelerate")
		brake_input = Input.get_action_strength("brake")
		steer_input = Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right")
	# --- REVERSE TOGGLE ---
		if not is_ai:
			if Input.is_action_just_pressed("reverse"):
				reversing = not reversing
				if reversing:
					current_gear = -1
				else:
					current_gear = 1

	_drive(delta, throttle_input, brake_input, steer_input)
	total_race_time += int(delta * 1000)
	
	if hard_frozen:
		velocity = Vector3.ZERO
		return
	# Track distance travelled
	distance_travelled += velocity.length() * delta







func _drive(delta: float, accel: float, brake: float, steer: float) -> void:
	var drift_input := false
	var nitrous := false

	if not is_ai:
		if Input.is_action_pressed("drift"):
			drift_input = true

	if not is_ai:
		# Player is holding NOS
		if Input.is_action_pressed("nos"):
			# Only allow nitro if not cooling down
			if nitro_cooldown <= 0.0:
				nitrous = true
		else:
			nitrous = false

		# --- NITRO TIMER SYSTEM ---
		if nitrous:
			nitro_time += delta
			nitro_active = true

			# If nitro exceeds 4 seconds, block it
			if nitro_time >= 4.0:
				nitro_active = false
				nitro_cooldown = 8.0  # start cooldown
		else:
			nitro_active = false

		# Count down cooldown
		if nitro_cooldown > 0.0:
			nitro_cooldown -= delta

		# Reset nitro timer ONLY when cooldown is finished
		if nitro_cooldown <= 0.0 and not nitro_active:
			nitro_time = 0.0



	var target_drift := 0.0
	if drift_input:
		target_drift = 1.0

	drift_factor = lerp(drift_factor, target_drift, delta * 6.0)
	drifting = drift_factor > 0.1

	steering = lerp(steering, steer, delta * 6.0)

	var forward := -transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()

	var right := transform.basis.x.normalized()

	var sideways_speed := velocity.dot(right)
	sideways_speed = lerp(sideways_speed, 0.0, delta * 8.0)

	var speed := velocity.length()
	var speed_kmh := speed * 3.6
	var throttle_steer := 0.0

	# --- CAR ORIENTATION ---
	if not drifting:
		rotate_y(steering * turn_speed * delta)
		lateral_friction = 1.2
	else:
		var drift_steer := steering * (turn_speed * 0.35)
		rotation.y += drift_steer * delta
		var slip_strength := 2.0 * drift_factor
		var grip :float= clamp(lateral_friction * 0.8, 0.0, 1.0)
		velocity = velocity.rotated(Vector3.UP, throttle_steer * grip * delta)
		lateral_friction = lerp(1.2, 0.12, drift_factor)

	car_model.rotation_degrees.z = lerp(car_model.rotation_degrees.z, -steering * 10.0, delta * 8.0)

	forward = -transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()
	right = transform.basis.x.normalized()

	var wall_block := false
	var wall_scrape := false

	# --- COLLISION HANDLING (SEAMS + RIGIDBODIES) ---
	# --- COLLISION HANDLING (SEAM-PROOF + WALL SCRAPE + PROPS) ---
	for i in range(get_slide_collision_count()):
		var col := get_slide_collision(i)
		var other := col.get_collider()
		if other is CarController:
			var other_car := other as CarController

			var hit_dir := (other_car.global_position - global_position).normalized()
			hit_dir.y = 0.0

			# Compare masses
			var mass_ratio :int= mass / max(other_car.mass, 1.0)

			# Prevent crazy outcomes
			mass_ratio = clamp(mass_ratio, 0.5, 2.0)

			# Speed contributes to shove force
			var shove_force := velocity.length() * mass_ratio * 0.08

			other_car.velocity += hit_dir * shove_force

		# Raw normal
		var n := col.get_normal()
		n.y = 0.0
		n = n.normalized()

		# --- PROP PUSH (RigidBody3D) ---
		# --- COLLISION HANDLING (SEAM-PROOF + WALL SCRAPE + PROPS) ---
	for i in range(get_slide_collision_count()):
		var col := get_slide_collision(i)
		var other := col.get_collider()
		
		# Raw normal
		var n := col.get_normal()
		n.y = 0.0
		n = n.normalized()

		# --- PROP PUSH (RigidBody3D) ---
		if other is RigidBody3D:
			var flat_n := Vector3(n.x, 0.0, n.z).normalized()
			var mass_factor :float= clamp(1200.0 / mass, 0.4, 1.0)
			var push_force :float= clamp(velocity.length() * 0.10, 1.0, 5.0) * mass_factor

			var impulse_pos := global_position
			impulse_pos.y -= 0.45

			# Ignore upward normals (ramps)
			if col.get_normal().y <= 0.25:
				other.apply_impulse(-flat_n * push_force, impulse_pos)

			# Stabilize car
			velocity.y = min(velocity.y, 0.0)
			rotation_degrees.x = lerp(rotation_degrees.x, 0.0, delta * 8.0)
			rotation_degrees.z = lerp(rotation_degrees.z, 0.0, delta * 8.0)

			continue

		# --- SEAM FILTER (IGNORE MICRO NORMALS) ---
		if n.length() < 0.45:
			continue

		# Ignore normals pointing upward (floor seams)
		if n.dot(Vector3.UP) > 0.55:
			continue

		# Use the forward/right already computed earlier in _drive()
		var front_dot := forward.dot(n)
		var side_dot := right.dot(n)

		# Ignore normals not facing the car
		if front_dot > -0.45:
			continue

		# Ignore normals not strongly sideways
		if abs(side_dot) < 0.35:
			continue

		# --- REAL WALL DETECTED ---
		if front_dot < -0.85:
			wall_block = true

		if abs(side_dot) > 0.55:
			wall_scrape = true

	# --- RPM & GEARS ---
	if speed_kmh < 2.0:
		if accel > 0.1:
			rpm = lerp(rpm, idle_rpm + 2500.0, delta * 2.5)
		else:
			rpm = lerp(rpm, idle_rpm, delta * 3.0)
	else:
		var wheel_rpm: float = speed_kmh * gear_ratios[current_gear - 1] * 35.0
		rpm = lerp(rpm, wheel_rpm, delta * 4.0)

	rpm = clamp(rpm, idle_rpm, max_rpm)
	update_gears(speed_kmh)

	var torque_factor := rpm / max_rpm

	# --- DRIVETRAIN ---
	var traction_factor := 1.0
	var launch_grip := 1.0

		# --- DRIVETRAIN BEHAVIOR FLAVOR ---
	if transmission == "Front wheel drive":
		# More understeer, stable, safe
		lateral_friction = lerp(lateral_friction, 1.05, delta * 2.0)
		steering *= 0.95  # slightly calmer steering
	elif transmission == "Rear wheel drive":
		# More oversteer, playful
		lateral_friction = lerp(lateral_friction, 0.95, delta * 2.0)
		var yaw_boost :float= clamp(speed_kmh / 120.0, 0.0, 1.0)
		velocity = velocity.rotated(Vector3.UP, steering * yaw_boost * 0.12 * delta)
	elif transmission == "Four wheel drive":
		# More grip, more stability
		lateral_friction = lerp(lateral_friction, 1.15, delta * 2.0)
		steering *= 1.05



	var accel_force := 0.0

	if accel > 0.0:
		if reversing:
			# --- REVERSE MOVEMENT ---
			var rev_force := acceleration_calc * 0.35   # MUCH WEAKER
			velocity -= forward * rev_force * delta

			# Cap reverse speed
			var flat_rev := Vector3(velocity.x, 0, velocity.z)
			if flat_rev.length() > reverse_speed_limit:
				flat_rev = flat_rev.normalized() * reverse_speed_limit
			velocity.x = flat_rev.x
			velocity.z = flat_rev.z

		else:
			# --- FORWARD MOVEMENT ---
			var launch_boost := 1.0
			if current_gear == 1:
				launch_boost = 1.25

			accel_force = acceleration_calc * torque_factor * traction_factor * launch_boost * launch_grip
			velocity += forward * accel_force * delta

	else:
		var flat := Vector3(velocity.x, 0, velocity.z)
		var brake_power := ENGINE_BRAKE
		if drifting:
			brake_power = ENGINE_BRAKE * 0.05
		flat = flat.move_toward(Vector3.ZERO, brake_power * delta)
		velocity.x = flat.x
		velocity.z = flat.z

	if nitrous:
		nitro.show()
		velocity += forward * accel_force * 1.35 * delta
	else:
		nitro.hide()

	if brake > 0.1:
		var brake_force := brake_strength * (mass / 1200.0) * 1.4
		velocity = velocity.move_toward(Vector3.ZERO, brake_force * delta)

	velocity -= velocity * DRAG * delta

	var flat2 := Vector3(velocity.x, 0, velocity.z)
	var current_top_speed := top_speed
	if nitrous:
		current_top_speed = top_speed * nitro_top_speed_multiplier

	if flat2.length() > current_top_speed:
		flat2 = flat2.normalized() * current_top_speed

	velocity.x = flat2.x
	velocity.z = flat2.z

	if not is_ai and controls_enabled:
			Global.speed = SpeedSettings.convert_speed(speed_kmh)
			Global.gear = current_gear
			Global.speed_unit = SpeedSettings.get_unit_label()

			if reversing:
				Global.gear = -1
			else:
				Global.gear = current_gear

	current_speed = speed_kmh

	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = -0.01

	var flat_safe := Vector3(velocity.x, 0, velocity.z)
	if flat_safe.length() > HARD_LIMIT:
		flat_safe = flat_safe.normalized() * HARD_LIMIT
		velocity.x = flat_safe.x
		velocity.z = flat_safe.z

	velocity.y = clamp(velocity.y, -HARD_LIMIT, HARD_LIMIT)

	move_and_slide()

func set_waypoints(root: Node3D) -> void:
	waypoint_root = root
	waypoints = root.get_children()
	waypoints.sort_custom(_ai_sort_wp)
	current_wp = 0
	current_wp = _find_closest_waypoint()

	

func _ai_sort_wp(a: Node, b: Node) -> bool:
	var na_str := a.name.strip_edges().to_upper()
	var nb_str := b.name.strip_edges().to_upper()

	if na_str.begins_with("WP"):
		na_str = na_str.substr(2)
	if nb_str.begins_with("WP"):
		nb_str = nb_str.substr(2)

	var na := int(na_str) if na_str.is_valid_int() else 99999
	var nb := int(nb_str) if nb_str.is_valid_int() else 99999

	return na < nb

func _update_ai_inputs(delta: float) -> void:
	if waypoints.is_empty():
		ai_throttle = 0.0
		ai_brake = 1.0
		ai_steer = 0.0
		return

	var wp := waypoints[current_wp] as Node3D
	var target := wp.global_position

	var to_wp := target - global_position


	var dist := to_wp.length()

	# skip waypoint if too close
	if dist < 6.0:
		current_wp = (current_wp + 1) % waypoints.size()


	var dir := to_wp.normalized()

	var forward := -transform.basis.z
	forward = forward.normalized()

	# --- NEVER REVERSE ---
	var dot := forward.dot(dir)

	# waypoint behind the car
	if dot < -0.4:
		current_wp = (current_wp + 1) % waypoints.size()
		return


	# --- UNSTICK FROM WALLS ---
	for i in range(get_slide_collision_count()):
		var col := get_slide_collision(i)
		var other := col.get_collider()

		if other is CharacterBody3D and not (other is CarController):
			continue

		var n := col.get_normal()
		n.y = 0.0
		n = n.normalized()

		if n.length() < 0.35:
			continue

		var push := velocity.dot(n)
		if push > 0.0:
			velocity -= n * push

	# --- STEERING ---
	var angle := forward.signed_angle_to(dir, Vector3.UP)
	ai_steer = clamp(angle * 2.0, -1.0, 1.0)

	# --- THROTTLE ---
	ai_throttle = 1.0

	# --- CORNER BRAKING ---
	if abs(angle) > 0.6:
		ai_brake = 0.3
	else:
		ai_brake = 0.0
func update_waypoint():
	if is_ai:
		_update_ai_waypoint()
	else:
		_update_player_waypoint()

func _find_nearest_car() -> CarController:
	var nearest: CarController = null
	var best_dist := 99999.0

	for body in get_tree().get_nodes_in_group("cars"):
		if body == self:
			continue
		if not (body is CarController):
			continue

		var cc := body as CarController
		var d := cc.global_position.distance_to(global_position)
		if d < best_dist:
			best_dist = d
			nearest = cc

	return nearest


func _find_closest_waypoint() -> int:
	var best := 0
	var best_dist := 999999.0
	for i in range(waypoints.size()):
		var d :int= waypoints[i].global_position.distance_to(global_position)
		if d < best_dist:
			best_dist = d
			best = i
	return best

func _update_player_waypoint():
	if waypoints.is_empty():
		return

	var wp := waypoints[current_wp] as Node3D
	var dist := global_position.distance_to(wp.global_position)

	if dist < 6.0:
		current_wp = (current_wp + 1) % waypoints.size()


func _update_ai_waypoint():
	if waypoints.is_empty():
		return

	var wp := waypoints[current_wp] as Node3D
	var to_wp := wp.global_position - global_position
	to_wp.y = 0.0

	var dist := to_wp.length()

	# Skip waypoint if too close
	if dist < 8.0:
		current_wp = (current_wp + 1) % waypoints.size()
		return

	var dir := to_wp.normalized()
	var forward := -transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()

	var dot := forward.dot(dir)

	# If waypoint is behind the car, skip it
	if dot < -0.2:
		current_wp = (current_wp + 1) % waypoints.size()
		return


func distance_to_finish_line(lapline: Node3D) -> float:
	return global_position.distance_to(lapline.global_position)
	
func distance_to_next_wp() -> float:
	if waypoints.is_empty():
		return 0.0

	var wp := waypoints[current_wp] as Node3D
	return global_position.distance_to(wp.global_position)
func distance_travelled_in_current_lap() -> float:
	if waypoints.is_empty():
		return 0.0

	# Compute full lap length
	var lap_dist: float = 0.0
	for i in range(waypoints.size()):
		var a: Vector3 = waypoints[i].global_position
		var b: Vector3 = waypoints[(i + 1) % waypoints.size()].global_position
		lap_dist += a.distance_to(b)

	# Distance covered so far in this lap
	var dist: float = 0.0
	for i in range(current_wp):
		var a: Vector3 = waypoints[i].global_position
		var b: Vector3 = waypoints[(i + 1) % waypoints.size()].global_position
		dist += a.distance_to(b)

	# Add partial segment from car to next waypoint
	var next_wp := waypoints[current_wp] as Node3D
	dist += global_position.distance_to(next_wp.global_position)

	# Clamp to lap length
	return clamp(dist, 0.0, lap_dist)
