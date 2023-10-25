extends Node2D
class_name Monster_attack_box

var player_vector: Vector2
var player_direction: Vector2
var move_direction: Vector2
var is_tracking: bool = false
var track_speed: float = 1



# Child nodes:
var attack_area: Area2D
var track_timer: Timer
var explode_timer: Timer

# Other nodes:
var beats_manager: Beats_manager
var player: Player

# Signals:


func _ready():
	# Get child nodes:
	attack_area = get_node("Attack_area")
	track_timer = get_node("Track_timer")
	explode_timer = get_node("Explode_timer")
#	print(attack_move.attack_name)

	# Get other nodes:
	beats_manager = get_parent().get_parent().get_node("BeatsManager")
	player = get_parent().get_parent().get_node("Player")

	
	# Connect signals:

	is_tracking = true

func _process(delta):
	if is_tracking:
		handle_tracking(delta)
	else:
		pass
	pass

func handle_tracking(delta):
	player_vector = player.get_global_transform().origin - self.get_global_transform().origin
	player_direction = player_vector.normalized()
	var displacement = player_direction * track_speed
	set_global_position(self.get_global_transform().origin + displacement)
	pass
