extends State
class_name Enemy_Idle

@export var enemy: CharacterBody2D
@export var move_speed = 10.0

var player : CharacterBody2D
var move_direction: Vector2
var wander_time: float
var idling_time: float
var _is_wandering = false
var _is_idling = true

func randomize_wander():
	move_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)

func randomize_stop_time():
	idling_time = randf_range(1,3)

func Enter():
	player = get_tree().get_first_node_in_group("player")
	randomize_wander()
	
func Update(delta: float):
	if wander_time > 0 and _is_wandering:
		wander_time -= delta
	else: 
		randomize_wander()
		_is_wandering = false
		_is_idling = true
	
	if idling_time > 0 and _is_idling:
		idling_time -= delta
	else: 
		randomize_stop_time()
		_is_wandering = true
		_is_idling = false
	
func Physics_Update(delta:float):
	if !enemy: return
	if !_is_idling:
		enemy.velocity = move_direction * move_speed
	else:
		enemy.velocity = Vector2.ZERO
	
	var direction = player.global_position - enemy.global_position
	
	if direction.length() < 75:
		Transitioned.emit(self,"Follow")
