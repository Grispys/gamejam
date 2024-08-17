extends CharacterBody3D

# Variables for movement speed
const move_speed = 60.0
var rotation_speed  = 0.00004

# variables for completing the stage
var is_fruit_full = false
var is_detected = false

var is_flying = false


# Variables to handle rotation
var rotation_x  = 0.0
var rotation_y = 0.0

var input_direction: Vector3 = Vector3.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(_delta):
	input_direction = Vector3.ZERO
    
	if Input.is_action_pressed("fly"):
		is_flying = true

	if is_flying:
			if Input.is_action_pressed("move_forward"):
				input_direction -= transform.basis.z
			if Input.is_action_pressed("move_backward"):
				input_direction += transform.basis.z
			if Input.is_action_pressed("move_left"):
				input_direction -= transform.basis.x
			if Input.is_action_pressed("move_right"):
				input_direction += transform.basis.x
	else:
		if Input.is_action_pressed("move_forward"):
			input_direction -= transform.basis.x
		if Input.is_action_pressed("move_backward"):
			input_direction += transform.basis.x
		if Input.is_action_pressed("move_left"):
			input_direction -= transform.basis.x
		if Input.is_action_pressed("move_right"):
			input_direction += transform.basis.x
    

	input_direction = input_direction.normalized()
    
    # movement
	velocity = input_direction * move_speed
	move_and_slide()

    # mouse input for camera
	var mouse_movement = Input.get_last_mouse_velocity()
	rotation_x -= mouse_movement.y * rotation_speed
	rotation_y -= mouse_movement.x * rotation_speed
    
    # prevent camera from circling player vertically
	rotation_x = clamp(rotation_x, deg_to_rad(-89), deg_to_rad(89))
    
    # apply rotation to the character
	rotation_degrees.x = rad_to_deg(rotation_x)
	rotation_degrees.y = rad_to_deg(rotation_y)
