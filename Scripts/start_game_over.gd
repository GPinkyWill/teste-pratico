extends CanvasLayer

@onready var start_game_over_text: Label = $Start_GameOver_Text
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect
@onready var timer_game_over: Timer = $TimerGameOver

@export var player : CharacterBody2D
@export var enemy : CharacterBody2D

var timer_left = true
var start = true
var waitingStart = false
var gameOver = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_animations()
	check_Start_GameOver()
	


func check_Start_GameOver():
	if Input.is_action_just_pressed("ui_enter"):
		color_rect.visible = false
		waitingStart = false
		start = false
		player.gameStopped = false
			
	if player._is_dead or enemy._is_dead:
		if timer_left:
			timer_game_over.start()
			timer_left = false
		print(timer_game_over.time_left)
		player.gameStopped = true
		
	if gameOver and Input.is_action_just_pressed("ui_enter"):
		get_tree().change_scene_to_file("res://Scenes/world.tscn")

func update_animations():
	if start:
		animation_player.play("Start")
		timer.start()
		start = false
	elif waitingStart:
		animation_player.play("Waiting_Start")
		
	if gameOver:
		animation_player.play("Game_Over")
		

func _on_timer_timeout() -> void:
	waitingStart = true
	


func _on_timer_game_over_timeout() -> void:
	gameOver = true
