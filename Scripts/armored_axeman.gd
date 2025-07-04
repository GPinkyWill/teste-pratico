extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var attack_cdr_timer: Timer = $Attack_CDR_Timer

var _is_on_fight = false
var _is_ready = true
var _got_hurt = false
var enemy_health = 20
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
	enemy_health -= damage_received
	if enemy_health < 0 and !_is_dead:
		animation_player.play("death")
		_is_dead = true

func _on_attack_cdr_timer_timeout() -> void:
	_is_ready = true

		
		



#var speed = 75
#var player_chase = false
#var player = null
#var got_hurt = false


#@onready var hurt_timer: Timer = $Hurt_Timer
#
#
#func _physics_process(delta: float) -> void:
#	if player_chase and !got_hurt:
#		var dist = player.position - position
#		position += dist/speed
#		if dist > Vector2.ZERO:
#			sprite_2d.scale.x = 1
#		else:
#			sprite_2d.scale.x = -1
#	animation_controller()
#
#func _on_detection_area_body_entered(body: Node2D) -> void:
#	if body.is_in_group("player"):
#		player = body
#		player_chase = true
#
#
#func _on_detection_area_body_exited(body: Node2D) -> void:
#	if body.is_in_group("player"):
#		player = null
#		player_chase = false
#
#func animation_controller():
#	if !got_hurt:
#		if !player_chase:
#			animation_player.play("idle")
#		else:
#			animation_player.play("walk")
#	else:
#		animation_player.play("hurt")
#
#
#
#
#func take_damage(amout: int):
#	hurt_timer.start()
#	got_hurt = true
#	
#
#
#func _on_hurt_timer_timeout() -> void:
#	got_hurt = false
#
