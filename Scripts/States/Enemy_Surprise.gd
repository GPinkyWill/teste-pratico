extends State
class_name Enemy_Surprise
@export var enemy : CharacterBody2D

func Enter():
	enemy.is_jumping = true
	enemy.jump_timer.start()

func Physics_Update(delta: float):
	if !enemy.is_jumping:
		Transitioned.emit(self,"Follow")
