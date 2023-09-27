extends CharacterBody2D

const SPEED = 300.0
const PLAYER_DRAG = 50
const STEER_VELOCITY = 1

var input_direction: Vector2
var move_direction: Vector2
var facing_angle: float

var current_state: String
var current_substate: String

const STATE_RUN = "run"
const STATE_DANCE = "dance"
const SUBSTATE_ATTACK = "attack"
const SUBSTATE_DEFEND = "defend"
const SUBSTATE_DODGE = "dodge"

func _ready():
	current_state = STATE_RUN

func _physics_process(delta):
	match current_state:
		STATE_RUN:
			handle_run_state(delta)
		STATE_DANCE:
			handle_dance_state(delta)

func handle_run_state(delta):
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_direction:
		velocity = input_direction * SPEED
		facing_angle = input_direction.angle()
		set_global_rotation(facing_angle + PI/2)
	else:
		velocity = velocity.move_toward(Vector2(0, 0), PLAYER_DRAG)
	move_and_slide()

func handle_dance_state(delta):
	match current_substate:
		SUBSTATE_ATTACK:
			handle_attack_substate(delta)
		SUBSTATE_DEFEND:
			handle_defend_substate(delta)
		SUBSTATE_DODGE:
			handle_dodge_substate(delta)

func handle_attack_substate(delta):
	# Implement attack logic here
	pass

func handle_defend_substate(delta):
	# Implement defend logic here
	pass

func handle_dodge_substate(delta):
	# Implement dodge logic here
	pass

func _input(event):
	match current_state:
		STATE_RUN:
			handle_run_state_input(event)
		STATE_DANCE:
			handle_dance_state_input(event)

func handle_run_state_input(event):
	if event.is_action_pressed("dance"):
		print("Enter Dance State")
		current_state = STATE_DANCE
		current_substate = SUBSTATE_ATTACK

func handle_dance_state_input(event):
	# Problem is here. Attack state can ony detect attack.
	match current_substate:
		SUBSTATE_ATTACK:
			handle_attack_substate_input(event)
		SUBSTATE_DEFEND:
			handle_defend_substate_input(event)
		SUBSTATE_DODGE:
			handle_dodge_substate_input(event)

func handle_attack_substate_input(event):
	if event.is_action_pressed("attack"):
		print("Dance_Attack!")
		current_substate = SUBSTATE_DEFEND

func handle_defend_substate_input(event):
	if event.is_action_pressed("defend"):
		print("Dance_Defend!")
		current_substate = SUBSTATE_DODGE

func handle_dodge_substate_input(event):
	if event.is_action_pressed("dodge"):
		print("Dance_dodge!")
		current_state = STATE_RUN
