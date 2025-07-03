extends CharacterBody2D

const speed = 100
const friction = 540
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var attack_timer: Timer = $Attack_Timer
var is_attacking = false
var atk_oneshot = false

var player_health = 5
var damage_atk = 2




func _physics_process(delta: float) -> void:
	var input_axis_h = Input.get_axis("ui_left","ui_right")
	var input_axis_v = Input.get_axis("ui_up","ui_down")
	player_movement(input_axis_h,input_axis_v,delta)
	player_attack()
	update_animations(input_axis_h,input_axis_v)
	move_and_slide()
	
	
func player_movement(input_axis_h,input_axis_v,delta):
	if input_axis_h != 0:
		velocity.x = speed * input_axis_h
		#Vai garantir que o sprite esteja na direção correta caso vire ou se mova para cima ou para baixo
		sprite_2d.scale.x = sign(input_axis_h)
	else:
		velocity.x = move_toward(velocity.x, 0 , friction * delta)
		
	if input_axis_v != 0:
		velocity.y = speed * input_axis_v
	else:
		velocity.y = move_toward(velocity.y, 0, friction * delta)
	

func player_attack():
	if Input.is_action_just_pressed("ui_attack") and not is_attacking:
		is_attacking = true
	

func update_animations (input_axis_h,input_axis_v):
	if not is_attacking:
		if input_axis_h != 0 or input_axis_v != 0:
			animation_player.play("walk_01")
			
		else:
			animation_player.play("idle")
	if is_attacking and not atk_oneshot:
		attack_timer.start()
		print(attack_timer.time_left)
		animation_player.play("attack_front")
		atk_oneshot = true
		


func _on_attack_timer_timeout() -> void:
	is_attacking = false
	atk_oneshot = false
	print("para de atacar")
