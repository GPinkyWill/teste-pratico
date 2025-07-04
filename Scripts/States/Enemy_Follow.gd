extends State
class_name Enemy_Follow

var player: CharacterBody2D

@export var enemy : CharacterBody2D
@export var move_speed = 40.0

func Enter():
	player = get_tree().get_first_node_in_group("player")

func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	if direction.length() > 35:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2.ZERO
		Transitioned.emit(self,"Attack")
	if direction.length() > 100:
		Transitioned.emit(self, "idle")
