extends Node2D
class_name Monster_attack_box

var player_vector: Vector2
var player_direction: Vector2
var move_direction: Vector2
var is_tracking: bool = false
var track_speed: float = 100
var track_time: float
var explode_time: float
var track_beat: int = 1
var explode_beat: int = 1



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

	# Get other nodes:
	beats_manager = get_parent().get_node("BeatsManager")
	player = get_parent().get_node("Player")

	
	# Connect signals:

	# Others
	is_tracking = true
	track_timer.one_shot = true
	explode_timer.one_shot = true
	track_time = beats_manager.time_to_following_beat(track_beat)
	explode_time = explode_beat * beats_manager.beat_interval
	print(track_time)
	print(explode_time)
	track_timer.start(track_time)
	explode_timer.start(track_time + explode_time)
#	track_timer.start(1)
#	explode_timer.start(2)

func _process(delta):
	if is_tracking:
		handle_tracking(delta)
	else:
		pass
	pass

func handle_tracking(delta):
	player_vector = player.get_global_transform().origin - self.get_global_transform().origin
	player_direction = player_vector.normalized()
	var displacement = player_direction * track_speed * delta
	set_global_position(self.get_global_transform().origin + displacement)
	pass
	


# Callbacks
func _on_track_timer_timeout():
	print("Done tracking")
	is_tracking = false

func _on_explode_timer_timeout():
	print("Explode!")
