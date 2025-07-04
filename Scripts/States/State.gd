extends Node
class_name State
signal Transitioned
signal Death
# Quando entra no State
func Enter():
	pass 

# Quando sai do State
func Exit():
	pass

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
