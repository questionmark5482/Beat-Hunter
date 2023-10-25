extends CharacterBody2D

const SPEED = 300
const MONSTER_DRAG = SPEED * 0.2
const STEER_VELOCITY = 0.01


var player_vector: Vector2
var player_direction: Vector2
var move_direction: Vector2
var facing_angle: float


# State Machine
var current_state: String
const STATE_CHASE= "chase"
const STATE_IDLE = "idle"

# Child nodes: to be taken down in _ready()
var audio_player: AudioStreamPlayer
var health_bar: Health_bar

# Other nodes to be taken down in _ready()
var player: Player
var player_weapon: Weapon

func _ready():
	# State Machine
	current_state = STATE_CHASE
	
	# Get necessary child nodes:
#	audio_player = get_node("AudioStreamPlayer")
	health_bar = Health_bar.new(3)
	
	# Get other nodes:
	player = get_parent().get_node("Player")
	player_weapon = player.get_node("Weapon")
	
	# Connect signals:
	health_bar.health_changed.connect(_on_health_changed)
	player_weapon.fired.connect(_on_weapon_fired)


	
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
#	facing_angle = player_direction.angle()
#	set_global_rotation(facing_angle + PI/2)
	handle_rotate(player_direction, delta)
	velocity = Vector2(1, 0).rotated(facing_angle) * SPEED * -1
#	velocity = velocity.move_toward(Vector2(0, 0), MONSTER_DRAG)
	move_and_slide()
	
func handle_rotate(player_direction, delta):
	var d_theta = fmod(player_direction.angle() - facing_angle + 10*PI, 2*PI) - PI
#	print(d_theta)
	facing_angle += STEER_VELOCITY * signf(d_theta)
	set_global_rotation(facing_angle - PI/2)
	
#	rotation = lerp_angle(rotation, d_theta, STEER_VELOCITY * delta)
	pass
	
func handle_idle_state(delta):
	pass
	
func _on_health_changed():
	pass
	
func _on_weapon_fired(damaged_bodies, damage):
	if self in damaged_bodies:
		health_bar.decrease_health(damage)


