extends Node2D
var timer: Timer
var audio_player: AudioStreamPlayer

var start_time: float
var total_beats: int = 64
var bpm: float = 100
var beat_interval: float = 60/bpm
var current_beat: int = 0
var current_beat_time: float


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_child(0)
	timer.wait_time = beat_interval
	timer.start()
	audio_player = get_child(1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	current_beat += 1
	audio_player.play()
#	print("Beat!")
	pass # Replace with function body.
