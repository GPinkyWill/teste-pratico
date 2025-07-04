extends Area2D


func _ready() -> void:
	connect("area_entered",self._on_area_entered)
	
func _on_area_entered(hitBox : HitBox) -> void:
	var attacker = hitBox.attacker
	
	if owner.has_method("take_damage") and attacker != owner:
		owner.take_damage(hitBox.damage)
