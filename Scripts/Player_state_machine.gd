extends CharacterBody2D

class_name Player

const SPEED = 700.0
const PLAYER_DRAG = SPEED * 0.2
const STEER_VELOCITY = 1

var input_direction: Vector2
var move_direction: Vector2
var facing_angle: float

var current_state: String
var current_substate: String

var input_beat: int = -2
var input_locked: bool = false

const STATE_RUN = "run"
const STATE_DANCE = "dance"
const SUBSTATE_IDLE = "idle"
const SUBSTATE_ATTACK = "attack"
const SUBSTATE_DEFEND = "defend"
const SUBSTATE_DODGE = "dodge"


@export var attack_move: Attack_move

# Other nodes to be taken down in _ready()
var monster
var beats_manager: Beats_manager

# Child nodes: to be taken down in _ready()
var audio_player: AudioStreamPlayer
var health_bar: Health_bar
var weapon: Weapon


func _ready():
	# State machine:
	current_state = STATE_RUN
	
	# Get necessary child nodes:
	audio_player = get_node("AudioStreamPlayer")
	health_bar = Health_bar.new(3)
	weapon = get_node("Weapon")

	# Get other nodes:
	monster = get_parent().get_node("Monster")
	beats_manager = get_parent().get_node("BeatsManager")
	
	# Connect signals:
	health_bar.health_changed.connect(_on_health_changed)
	weapon.fired.connect(_on_weapon_fired)
	beats_manager.beat_information.connect(_on_beat)
	

func _physics_process(delta):
#	print(str(beats_manager.calculate_input_beat(Time.get_unix_time_from_system())))
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
	pass

func handle_attack_substate(delta):
	pass

func handle_defend_substate(delta):
	print("Dance_Defend!")
	current_substate = SUBSTATE_IDLE
	pass

func handle_dodge_substate(delta):
	print("Dance_dodge!")
	current_substate = SUBSTATE_IDLE
	pass

func _input(event):
	match current_state:
		STATE_RUN:
			handle_run_state_input(event)
		STATE_DANCE:
			handle_dance_state_input(event)

func handle_run_state_input(event):
	if event.is_action_pressed("dance"):
#		print("Enter Dance State")
		current_state = STATE_DANCE
		current_substate = SUBSTATE_IDLE

func handle_dance_state_input(event):
	if event.is_action_released("dance"):
#		print("Exit Dance State")
		current_state = STATE_RUN
		return
	if is_dance_input(event):
		if input_locked:
			print("Input locked!")
			return
		else:
			input_beat = beats_manager.calculate_input_beat(Time.get_unix_time_from_system())
			if input_beat == -1:
				print("Dance input, not on beat!")
				input_locked = true
			else:
				print("Dance input, on beat no. " + str(input_beat) + "!")
				match current_substate:
					SUBSTATE_IDLE:
						handle_idle_substate_input(event)
					SUBSTATE_ATTACK:
						handle_attack_substate_input(event)
					SUBSTATE_DEFEND:
						handle_defend_substate_input(event)
					SUBSTATE_DODGE:
						handle_dodge_substate_input(event)

func handle_idle_substate_input(event):
	if event.is_action_pressed("attack"):
		current_substate = SUBSTATE_ATTACK
		weapon.start_attack(beats_manager.calculate_input_beat(Time.get_unix_time_from_system()))
	if event.is_action_pressed("defend"):
		current_substate = SUBSTATE_DEFEND
	if event.is_action_pressed("dodge"):
		current_substate = SUBSTATE_DODGE

func handle_attack_substate_input(event):
	pass

func handle_defend_substate_input(event):
	pass

func handle_dodge_substate_input(event):
	pass
	
func is_dance_input(event) -> bool:
	if event.is_action_pressed("attack") or event.is_action_pressed("defend") or event.is_action_pressed("dodge"):
		return true
	else:
		return false
	

	
# Callbacks
func _on_health_changed():
	pass
	
func _on_weapon_fired(damaged_bodies, damage):
	current_substate = SUBSTATE_IDLE

func _on_beat(current_beat):
	input_locked = false
#	print("current beat is " + str(current_beat))
#	print_state_machine()
	pass

# Debug:
func print_state_machine():
	print("Current state is: " + current_state + ", current substate is: " + current_substate + ".")
