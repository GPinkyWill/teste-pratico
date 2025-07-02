extends State
class_name Armored_Axeman_Fight

var player: CharacterBody2D
var breath_time : float
var direction
@export var enemy: CharacterBody2D
@export var move_speed := 80
@export var timer_fight: Timer

func Enter():
	player = get_tree().get_first_node_in_group("player")
	time_to_fight()
	

func time_to_fight():
	enemy.timer_fight.start(10)
	enemy._on_fight = true
	
func Update(delta: float):
	direction = player.global_position - enemy.global_position
	checa_direcao_player()
	if enemy._on_fight and direction.length() < 75:
		enemy.can_hit = true
		enemy.velocity = Vector2()
	else:
		enemy.can_hit = false
		
func Physics_Update(delta: float):
	#var direction = player.global_position - enemy.global_position
	
	if direction.length() < 200 and direction.length() > 80:
		Transitioned.emit(self, "Follow")
	elif direction.length() > 200:
		enemy._on_fight = false
		Transitioned.emit(self,"tired")
		


func checa_direcao_player():
	if direction.abs().x > direction.abs().y:
		if direction.x > 0:
			enemy.direcao_atual = "direita"
		elif direction.x < 0:
			enemy.direcao_atual = "esquerda"
	elif direction.abs().x < direction.abs().y:
		if direction.y > 0:
			enemy.direcao_atual = "baixo"
		elif direction.y < 0:
			enemy.direcao_atual = "cima"
