extends CharacterBody2D


const SPEED = 300.0
var JUMP_VELOCITY = -400.0
var double_jump = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y > 500:
			velocity.y = 500

	# Handle jump.
	if is_on_floor():
		double_jump = 0

	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		if double_jump == 1:
			velocity.y = 400
		if !is_on_floor() and double_jump == 0:
			velocity.y = JUMP_VELOCITY
			double_jump = 1 

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
