extends CharacterBody2D

const SPEED = 300.0
const MONSTER_DRAG = SPEED * 0.2
const STEER_VELOCITY = 1

var player_vector: Vector2
var player_direction: Vector2
var move_direction: Vector2
var facing_angle: float

var current_state: String

const STATE_CHASE= "chase"
const STATE_IDLE = "idle"

var audio_player: AudioStreamPlayer

var  player
var health_bar: Health_bar

func _ready():
	current_state = STATE_CHASE
	audio_player = get_node("AudioStreamPlayer")
	player = get_parent().get_node("Player")
#	print(player.transform.origin)
	health_bar = Health_bar.new(3)

func _physics_process(delta):
	match current_state:
		STATE_CHASE:
			handle_chase_state(delta)
		STATE_IDLE:
			handle_idle_state(delta)

func handle_chase_state(delta):
	player_vector = player.get_global_transform().origin - self.get_global_transform().origin
	player_direction = player_vector.normalized()

	velocity = player_direction * SPEED
	facing_angle = player_direction.angle()
	set_global_rotation(facing_angle + PI/2)

	velocity = velocity.move_toward(Vector2(0, 0), MONSTER_DRAG)
	move_and_slide()
	
func handle_idle_state(delta):
	pass


