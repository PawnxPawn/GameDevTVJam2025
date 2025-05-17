extends Node

@export var win_dialogue: DialogueResource
@export var dialogue_title: String

func _ready() -> void:
    get_parent().puzzle_completed.connect(_on_puzzle_completed)

func _on_puzzle_completed() -> void:
    DialogueManager.show_example_dialogue_balloon(win_dialogue, dialogue_title)