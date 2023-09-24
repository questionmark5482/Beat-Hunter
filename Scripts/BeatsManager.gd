extends Node2D
var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_child(0)
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
