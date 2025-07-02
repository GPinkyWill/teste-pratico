extends State
class_name Armored_Axeman_Tired

var player: CharacterBody2D
var breath_time : float

@export var enemy: CharacterBody2D
@export var move_speed := 80


func Enter():
	player = get_tree().get_first_node_in_group("player")
	time_to_breath()
	


func time_to_breath():
	breath_time = randf_range(2,5)
	
func Update(delta: float):
	if breath_time > 0:
		breath_time -= delta
		enemy.velocity = Vector2.ZERO
	else:
		Transitioned.emit(self,"idle")
		
func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() < 150:
		Transitioned.emit(self, "Follow")
	elif breath_time < 0:
		Transitioned.emit(self,"idle")
		
