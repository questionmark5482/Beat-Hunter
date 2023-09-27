extends Node2D
var beat_timer: Timer
var audio_player: AudioStreamPlayer

var start_time: float
var total_beats: int = 64
var bpm: float = 100
var beat_interval: float = 60/bpm
var current_beat: int = 0
var current_beat_time: float
var previous_time = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	beat_timer = get_node("BeatTimer")
	beat_timer.wait_time = beat_interval
	beat_timer.start()
	start_time = Time.get_unix_time_from_system()
	audio_player = get_node("AudioStreamPlayer")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	current_beat += 1
	audio_player.play()
	current_beat_time = Time.get_unix_time_from_system() - start_time
#	print("Beat!")
	pass # Replace with function body.
