extends Node

class_name Weapon

var damaged_bodies: Array
var is_attacking: bool = false
var attack_beat: int = -2

# Child nodes:
var attack_area: Area2D
var attack_timer: Timer
@export var attack_move: Attack_move

# Other nodes:
var beats_manager: Beats_manager

# Signals:
signal fired(damaged_bodies, damage)


func _ready():
	# Get child nodes:
	attack_area = get_node("Attack_area")
	attack_timer = get_node("Attack_timer")
#	print(attack_move.attack_name)

	# Get other nodes:
	beats_manager = get_parent().get_parent().get_node("BeatsManager")
	
	# Connect signals:
	beats_manager.beat_information.connect(_on_beat)

	
func _process(delta):
	pass

func start_attack(input_beat):
	is_attacking = true
	attack_beat = input_beat + attack_move.delay_beat
#	print("Starting attack! Attacking on beat no. " + str(attack_beat) + ", current beat is no. " + str(input_beat))
	pass
	
func _on_beat(current_beat):
	if is_attacking:
		if current_beat == attack_beat:
			execute_attack()
			is_attacking = false
	
func execute_attack():
#	audio_player.play()
#	print(str(attack_move.attack_name) + "! Damage = " + str(attack_move.damage))
	damaged_bodies = attack_area.get_overlapping_bodies()
	fired.emit(damaged_bodies, attack_move.damage)
	pass

# Callbacks:
func _on_attack_timer_timeout():
#	print("executing attack")
#	execute_attack()
	pass
