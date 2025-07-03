extends CharacterBody2D


var speed = 75
var player_chase = false
var player = null
var dist 
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	if player_chase:
		var dist = player.position - position
		position += dist/speed
		if dist > Vector2.ZERO:
			sprite_2d.scale.x = 1
		else:
			sprite_2d.scale.x = -1
	animation_controller()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null
		player_chase = false

func animation_controller():
	if !player_chase:
		animation_player.play("idle")
	else:
		animation_player.play("walk")
