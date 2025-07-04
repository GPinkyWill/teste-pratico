class_name HurtBox
extends Area2D



	
func _ready() -> void:
	connect("area_entered",self._on_area_entered)
	
func _on_area_entered(hitBox : HitBox) -> void:
	if hitBox == null: return
	if owner.has_method("take_damage"):
		owner.take_damage(hitBox.damage)	
