extends State
class_name Armored_Axeman_Follow

@export var enemy: CharacterBody2D
@export var move_speed:= 100.0

var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("player")
	
func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 75:
		enemy.velocity = direction.normalized() * move_speed
	else:
		Transitioned.emit(self,"fight")

	if direction.length() > 200:
		Transitioned.emit(self, "tired")
		return
	
