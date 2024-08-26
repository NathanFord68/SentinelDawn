class_name Controller
extends CharacterBody3D


## The default walk speed of the player
@export var speed := 5.0

## The default sprint speed of the player
@export var sprint_speed := 10.0

## The velocity at which the player leaves the ground
@export var jump_velocity := 4.5

## How sensitive the camera rotation is
@export var rotate_speed := .5

## How sensitive the camera pitch is
@export var pitch_sensitivity := .01

## How far up can the player look, 0 deg is ground plane
@export var max_pitch_angle := 60.0

## How far down can the player look, 0 deg is ground plane
@export var min_pitch_angle := -45.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_camera(event.velocity)

func _physics_process(delta: float) -> void:
	var _movement_speed = sprint_speed if Input.is_action_pressed("Sprint") else speed
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity

	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * _movement_speed
		velocity.z = direction.z * _movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, _movement_speed)
		velocity.z = move_toward(velocity.z, 0, _movement_speed )

	move_and_slide()

func rotate_camera(velocity: Vector2) -> void:
	# Rotate the player about yaw
	rotate_y(deg_to_rad( -velocity.x * get_process_delta_time() * rotate_speed))
	
	$Camera3D.rotate_x(-velocity.y * get_process_delta_time() * pitch_sensitivity)
	
	$Camera3D.rotation.x = clamp($Camera3D.rotation.x, deg_to_rad(min_pitch_angle), deg_to_rad(max_pitch_angle))
	
