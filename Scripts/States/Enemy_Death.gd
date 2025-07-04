extends State
class_name Enemy_Death

@onready var feet: CollisionShape2D = $"../../feet"

func Enter():
	feet.disabled = true
