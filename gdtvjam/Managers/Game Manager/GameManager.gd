extends Node

enum character_size
{
    NORMAL = 1,
    SMALL = 0
}

var is_credits_called = false

var current_player_size: character_size = character_size.NORMAL

var player_size_when_entered: character_size
var level_first_load: bool