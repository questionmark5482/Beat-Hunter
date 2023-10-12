extends Resource

class_name Health_bar

# Health bar variables
var max_health: int = 3
var current_health: int = 3

# Initialize the health bar
func _init(input_max_health):
	max_health = input_max_health
	current_health = input_max_health

# Method to decrease health
func decrease_health(amount: int):
	current_health -= amount
	if current_health <= 0:
		print("Health <= 0!")
		current_health = 0

# Method to increase health
func increase_health(amount: int):
	current_health += amount
	if current_health > max_health:
		current_health = max_health

# Method to get current health percentage
func get_health_percentage():
	return current_health / max_health

# Method to set max health
func set_max_health(amount: int):
	max_health = amount
	if current_health > max_health:
		current_health = max_health
