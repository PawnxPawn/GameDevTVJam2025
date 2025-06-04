extends Area2D

@export var death_type: GameManager.death_type = GameManager.death_type.NONE

func _on_body_entered(body: Node2D) -> void:
	if body is player:
		body.reset_level(death_type)
