extends ProgressBar

@onready var life_timer: Timer = $Life_Timer

@export var character_health : CharacterBody2D

var actual_health
var health

func _ready() -> void:
	health = character_health.health
	max_value = health
	visible = false
	
func _process(delta: float) -> void:
	actual_health = character_health.health
	Update_Health()

func Update_Health():
	if actual_health != health:
		life_timer.start()
		visible = true
		health = actual_health
		if actual_health < 0:
			visible = false
	value = actual_health

func _on_life_timer_timeout() -> void:
	visible = false
