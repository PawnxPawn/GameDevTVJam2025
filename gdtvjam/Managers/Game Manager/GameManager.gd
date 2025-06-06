extends Node

enum character_size
{
	NORMAL = 1,
	SMALL = 0
}

enum directions
{
	NORTH,
	SOUTH,
	EAST,
	WEST
}

var block_locations: Dictionary = {
	&"7A": Vector2(32,28),
}

var is_credits_called = false

var current_player_size: character_size = character_size.NORMAL

var player_size_when_entered: character_size
var level_first_load: bool = true

var player_initial_pos: Vector2
var entered_direction: directions

var initial_game_run: bool = true
var can_move: bool = true
var is_zoomed: bool = false

func _ready() -> void:
	DialogueManager.dialogue_started.connect(on_dialogue_started)
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)

func on_dialogue_started(_resource: DialogueResource) -> void:
	can_move = false

func on_dialogue_ended(_resource: DialogueResource) -> void:
	can_move = true