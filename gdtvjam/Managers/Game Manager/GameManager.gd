extends Node

enum character_size
{
	NORMAL = 1,
	SMALL = 0
}

enum death_type
{
	NONE,
	WATER,
	PIT,
	TRIPWIRE,
	OUTOFBOUNDS,
}


enum directions
{
	NORTH,
	SOUTH,
	EAST,
	WEST
}

const DEFAULT_BLOCK_LOCATIONS: Dictionary = {
	&"EA": Vector2(30,30),
	&"1A": Vector2(31,95),
	&"6A": Vector2(352,222),
	&"7A": Vector2(32,28),
	&"9A": Vector2(165,-161),
	&"9B": Vector2(94,-161)
}

var block_locations: Dictionary = {
	&"EA": Vector2(30,30),
	&"1A": Vector2(31,95),
	&"6A": Vector2(352,222),
	&"7A": Vector2(32,28),
	&"9A": Vector2(165,-161),
	&"9B": Vector2(94,-161)
}


var is_credits_called = false
var has_initial_entrance_scene_ran: bool = false
var room_reset: bool = false
var first_room_reset: bool = true
var first_shrink: bool = true
var first_grow: bool = true
var has_won: bool = false

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
	if has_won:
		get_tree().change_scene_to_file("uid://d3a5nng4xkp3l")
