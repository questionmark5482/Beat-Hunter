extends CharacterBody2D


const SPEED = 300.0
const PLAYER_DRAG = 50
const STEER_VELOCITY = 1


var input_direction: Vector2
var move_direction: Vector2
var facing_angle: float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_direction:
		velocity = input_direction * SPEED
		facing_angle = input_direction.angle()
		set_global_rotation(facing_angle + PI/2)
	else:
		velocity = velocity.move_toward(Vector2(0, 0), PLAYER_DRAG)
	move_and_slide()
	

	

