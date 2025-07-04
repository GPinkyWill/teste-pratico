extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
func _ready() -> void:
	pass
func _physics_process(delta: float) -> void:
	move_and_slide()
	update_animations()
	
func update_animations():
	if velocity != Vector2.ZERO:
		animation_player.play("walk")
	else:
		animation_player.play("idle")
	if velocity.x > 0:
		sprite_2d.flip_h = false
	elif velocity.x < 0:
		sprite_2d.flip_h = true
		
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
