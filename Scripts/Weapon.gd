extends Node

class_name Weapon

var damaged_bodies: Array

# Child nodes:
var attack_area: Area2D
var attack_timer: Timer
@export var attack_move: Attack_move

# Signals:
signal fired(damaged_bodies, damage)


func _ready():
	# Get child nodes:
	attack_area = get_node("Attack_area")
	attack_timer = get_node("Attack_timer")
#	print(attack_move.attack_name)
	
func _process(delta):
	pass

func start_attack():
	attack_timer.start(attack_move.delay)
	pass
	
func execute_attack():
#	audio_player.play()
	print(str(attack_move.attack_name) + "! Damage = " + str(attack_move.damage))
	damaged_bodies = attack_area.get_overlapping_bodies()
	fired.emit(damaged_bodies, attack_move.damage)
	pass


func _on_attack_timer_timeout():
	print("executing attack")
	execute_attack()
