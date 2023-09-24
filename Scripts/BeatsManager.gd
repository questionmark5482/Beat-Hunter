extends Node2D
var timer: Timer

var start_time: float
var total_beats: int = 64
var bpm: float = 100
var beat_interval: float = 60/bpm
var current_beat: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_child(0)
	timer.wait_time = beat_interval
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	current_beat += 1
	print("Beat!")
	pass # Replace with function body.
