extends Node

@export var dialgoue_to_play: DialogueResource
@export var dialogue_name: String
@export var next_level: PackedScene

func _ready() -> void:
    AudioManager.level_music.play()
    DialogueManager.dialogue_ended.connect(_on_dialogue_end)
    DialogueManager.show_example_dialogue_balloon(dialgoue_to_play, dialogue_name)

func _on_dialogue_end(_resource: DialogueResource) -> void:
    GameManager.entered_direction = GameManager.directions.SOUTH
    get_tree().change_scene_to_packed(next_level)
