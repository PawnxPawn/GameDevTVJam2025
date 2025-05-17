extends Node

@export var cave_level: PackedScene

func _on_entrance_body_entered(body:Node2D) -> void:
    if (body.is_in_group("player")):
        get_tree().change_scene_to_packed(cave_level)