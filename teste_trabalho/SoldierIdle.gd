extends State
class_name Armored_Axeman_Idle

var player: CharacterBody2D

@export var enemy: CharacterBody2D
@export var move_speed := 80

var move_direction: Vector2
var wander_time: float
var idle_time: float
# Called when the node enters the scene tree for the first time.
func randomize_wander():
	move_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	idle_time = randf_range(1,8)
	wander_time = randf_range(1,3) + idle_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func Enter():
	player = get_tree().get_first_node_in_group("player")
	randomize_wander()
	
func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
func Physics_Update(delta: float):
	if enemy:
		if wander_time > idle_time:
			enemy.velocity = move_direction * move_speed
		else:
			enemy.velocity = Vector2.ZERO
	var direction = player.global_position - enemy.global_position
	
	if direction.length() < 150:
		Transitioned.emit(self, "Follow")
		
		return
	
