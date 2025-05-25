extends Area2D

@export var next_level: PackedScene
@export var entrance_direction: GameManager.directions
@export var size_check: bool

func _on_body_entered(body:Node2D) -> void:
    if (body.is_in_group("player")):
        print("Player is here")
        if (size_check):
            if (GameManager.current_player_size != GameManager.character_size.SMALL):
                return
        GameManager.level_first_load = true
        GameManager.entered_direction = entrance_direction
        get_tree().call_deferred("change_scene_to_packed", next_level)
