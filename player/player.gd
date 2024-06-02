extends CharacterBody3D

const SPEED = 20.0
const ROTATE_SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("hop") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("turn_left", "turn_right", "move_forward", "none")
	var direction := (transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	
	print("%s | %s" % [input_dir, direction])
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	rotate_y(-deg_to_rad(input_dir.x * ROTATE_SPEED))
	#$Model.rotation.y = clamp($Model.rotation.y, 0, PI/2)

	move_and_slide()
