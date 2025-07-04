extends CharacterBody2D

const speed = 100
const friction = 540
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var attack_timer: Timer = $Attack_Timer

@onready var hurt_timer: Timer = $Hurt_Timer


var is_attacking = false
var atk_oneshot = false

var player_health = 50
var _got_hurt = false
var _got_hurt_oneshot = true
var _is_dead = false




func _physics_process(delta: float) -> void:
	var input_axis_h = Input.get_axis("ui_left","ui_right")
	var input_axis_v = Input.get_axis("ui_up","ui_down")

	player_movement(input_axis_h,input_axis_v,delta)
	player_attack()
	update_animations(input_axis_h,input_axis_v)
	move_and_slide()
	
	
func player_movement(input_axis_h,input_axis_v,delta):
	if _is_dead: return
	
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
	if Input.is_action_just_pressed("ui_attack") and not is_attacking and not _is_dead:
		is_attacking = true
	

func update_animations (input_axis_h,input_axis_v):
	if _is_dead: return
	
	if !is_attacking and !_got_hurt:
		if input_axis_h != 0 or input_axis_v != 0:
			animation_player.play("walk_01")
		else:
			animation_player.play("idle")

	if is_attacking and !atk_oneshot:
		attack_timer.start()
		animation_player.play("attack_front")
		atk_oneshot = true
		
	if _got_hurt and _got_hurt_oneshot:
		animation_player.play("hurt")
		hurt_timer.start()
		_got_hurt_oneshot = false


func take_damage(damage_received):
	_got_hurt = true
	player_health -= damage_received
	
	if player_health < 0 and !_is_dead:
		animation_player.play("death")
		print("morri")
		_is_dead = true
		
		
func _on_attack_timer_timeout() -> void:
	is_attacking = false
	atk_oneshot = false


func _on_hurt_timer_timeout() -> void:
	_got_hurt = false
	_got_hurt_oneshot = true
