extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var attack_cdr_timer: Timer = $Attack_CDR_Timer

var _is_on_fight = false
var _is_ready = true
var _got_hurt = false
var health = 20
var _is_dead = false
func _ready() -> void:
	pass
func _physics_process(delta: float) -> void:
	update_animations()
	move_and_slide()
	
	
func update_animations():
	if _is_dead: return
	
	if velocity.x > 0:
		sprite_2d.scale.x = 1
	elif velocity.x < 0:
		sprite_2d.scale.x = -1
		
	if !_is_on_fight:
		if velocity != Vector2.ZERO:
			animation_player.play("walk")
		else:
			animation_player.play("idle")
	
	if _is_on_fight and _is_ready: 
		animation_player.play("attack_01")
		attack_cdr_timer.start()
		_is_ready = false
	
	if _got_hurt:
		animation_player.play("hurt")
		_got_hurt = false
		
		
	
	
func take_damage(damage_received):
	_got_hurt = true
	health -= damage_received
	if health < 0 and !_is_dead:
		animation_player.play("death")
		_is_dead = true

func _on_attack_cdr_timer_timeout() -> void:
	_is_ready = true
