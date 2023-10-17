extends Node2D
class_name Beats_manager

var beat_timer: Timer
var audio_player: AudioStreamPlayer

var start_time: float
var total_beats: int = 64
var bpm: float = 100
var beat_interval: float = 60/bpm
var current_beat: int = 0
var current_beat_time: float
var previous_time = 0

var input_tolerance: float = 1. / 8.   # in the unit of beat!
var input_bias: float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	beat_timer = get_node("BeatTimer")
	beat_timer.wait_time = beat_interval
	beat_timer.start()
	start_time = Time.get_unix_time_from_system()
	audio_player = get_node("AudioStreamPlayer")
	print(input_tolerance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func is_on_beat(input_time_global: float) -> bool:
	var input_time = input_time_global - start_time
	if input_time < input_upper_bound and input_time > input_lower_bound:
		return true
	else:
		return false

func time_to_following_beat(n: int) -> float:
	var current_time = Time.get_unix_time_from_system() - start_time
	return n * beat_interval + current_time - current_beat_time



# Callbacks
func _on_timer_timeout():
	current_beat += 1
#	audio_player.play()
	current_beat_time = Time.get_unix_time_from_system() - start_time
#	print("Beat!")
	pass # Replace with function body.

