extends State
class_name Enemy_Attack

var damage
var player : CharacterBody2D


@export var enemy : CharacterBody2D

func Enter(): 
	player = get_tree().get_first_node_in_group("player")

func Physics_Update(delta:float):
	var direction = player.global_position - enemy.global_position
	if direction.x > 0:
		enemy.sprite_2d.scale.x = 1
	else:
		enemy.sprite_2d.scale.x = -1
	if enemy._is_dead:
			Transitioned.emit(self,"Death")
	if direction.length() < 50:
		enemy._is_on_fight = true
		if player._is_dead:
			Transitioned.emit(self,"Idle")
			enemy._is_on_fight = false
	else:
		enemy._is_on_fight = false
		Transitioned.emit(self,"Follow")
